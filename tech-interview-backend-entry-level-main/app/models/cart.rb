class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  before_save :marcar_abandonado_se_preciso

  # Definir escopos com base em `updated_at`, pois não há `status`
  scope :abandonados, -> { where("updated_at < ?", 3.hours.ago) }
  scope :expirados, -> { where("updated_at < ?", 7.days.ago) }

  # Marcar carrinhos como "abandonados" zerando o total_price
  def marcar_como_abandonado!
    update(total_price: 0) if updated_at < 3.hours.ago
  end

  # Remover carrinhos abandonados há mais de 7 dias
  def self.remover_abandonados!
    expirados.delete_all
  end

  private

  def marcar_abandonado_se_preciso
    self.total_price = 0 if updated_at && updated_at < 3.hours.ago
  end
end
