class CartsController < ApplicationController
  before_action :find_or_create_cart, only: %i[show create destroy]

  # GET /cart/1
  def show
    @cart = find_or_create_cart
    render json: cart_response(@cart)
  end

  # POST /cart - Adiciona um produto ao carrinho
  def create
    product_id = params[:product_id]
    quantity = params[:quantity].to_i

    unless product_id
      return render json: { error: "Parâmetro product_id é obrigatório" }, status: :bad_request
    end

    @cart = find_or_create_cart
    product = Product.find_by(id: product_id)

    unless product
      return render json: { error: "Produto não encontrado" }, status: :not_found
    end

    add_product_to_cart(@cart, product, quantity)
  end

  # DELETE /cart/:product_id - Remove um produto do carrinho
  def destroy
    product_id = params[:product_id]
    item = CartItem.find_by(cart: @cart, product_id: product_id)

    unless item
      return render json: { error: "Produto não encontrado no carrinho" }, status: :not_found
    end

    item.destroy
    #update_cart_total(@cart)
    #render json: cart_response(@cart)
  end

  # DELETE /cart/empty - Remove carrinhos abandonados
  def cleanup_abandoned
    Cart.abandonados.destroy_all
    head :no_content
  end

  private

  def find_or_create_cart
    cart = Cart.find_by(id: session[:cart_id])
    return cart if cart.present?

    cart = Cart.new(total_price: 0.0)
    cart.save! # Garante que o ID seja gerado corretamente
    session[:cart_id] = cart.id
    cart
  end

  #def create_new_cart
  #  cart = Cart.create
  #  session[:cart_id] = cart.id
  #  cart
  #end

  def add_product_to_cart(cart, product, quantity)
    item = CartItem.find_or_initialize_by(cart: cart, product: product) #inivialzia
    item.quantity = (item.quantity || 0) + quantity
    if item.save!
      update_cart_total(@cart)
      render json: cart_response(cart), status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_cart_total(cart)
    #total = cart.cart_items.sum { |item| item.quantity * item.product.price }
    #cart.update(total_price: total)
    cart.update_total_price # ver se mando parametro PRA CLASSE!!!!!
  end

  # Constrói a resposta do carrinho
  def cart_response(cart)
    {
      id: cart.id,
      products: cart.cart_items.map do |item|
        {
          id: item.product.id,
          name: item.product.name,
          quantity: item.quantity,
          unit_price: item.product.price,
          total_price: item.quantity * item.product.price,
        }
      end,
      total_price: cart.total_price || 0.0,
    }
  end
end
