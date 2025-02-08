require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  # ----------------------- GET TESTS -------------------------
  setup do
    @cart = Cart.create!(total_price: 0.0) #(total_price: 0.0) # Criar um carrinho vazio
    cookies[:cart_id] = @cart.id # Armazenar cart_id no cookie
  end

  test "should get empty cart" do
    puts("")
    puts("")
    puts("GET-CART-TEST: should get empty cart")
    get cart_url as: :json

    assert_response :success
    json_response = JSON.parse(response.body)

    puts "GET /cart Response Body: #{response.body}" # Debugging output

    assert_equal @cart.id, json_response["id"]
    assert_empty json_response["products"]
    assert_equal "0.00", json_response["total_price"].to_s
    assert json_response["created_at"].present?, "created_at should be present"
    assert json_response["updated_at"].present?, "updated_at should be present"
  end

  #   test "should get cart with products" do
  #     product = Product.create!(name: "Test Product", price: 9.99)
  #     CartItem.create!(cart: @cart, product: product, quantity: 2)

  #     get cart_url, as: :json

  #     assert_response :success
  #     json_response = JSON.parse(response.body)

  #     puts "GET /cart with products Response: #{response.body}" # Debugging output

  #     assert_equal @cart.id, json_response["id"]
  #     assert_equal 1, json_response["products"].length
  #     assert_equal product.id, json_response["products"][0]["id"]
  #     assert_equal "Test Product", json_response["products"][0]["name"]
  #     assert_equal 2, json_response["products"][0]["quantity"]
  #     assert_equal "9.99", json_response["products"][0]["unit_price"].to_s
  #     assert_equal "19.98", json_response["products"][0]["total_price"].to_s
  #     assert json_response["created_at"].present?, "created_at should be present"
  #     assert json_response["updated_at"].present?, "updated_at should be present"
  #   end
end
