class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  before_save :update_total_price

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  private

  def update_total_price
    self.total_price = quantity * product.price
  end
end
