class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  # Escopos para carrinhos abandonados e expirados
  scope :abandonados, -> { where("updated_at < ?", 3.hours.ago) }
  scope :expirados, -> { where("updated_at < ?", 7.days.ago) }

  # Método para atualizar o preço total do carrinho
  def update_total_price
    total = cart_items.sum { |item| item.quantity * item.product.price }
    update(total_price: total)
  end
end
