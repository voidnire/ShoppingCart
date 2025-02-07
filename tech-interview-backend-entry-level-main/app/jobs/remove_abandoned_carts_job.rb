#class RemoveAbandonedCartsJob < ApplicationJob
#  queue_as :default
class RemoveAbandonedCartsJob
  include Sidekiq::Job

  def perform
    Rails.logger.info "🛒 Iniciando remoção de carrinhos abandonados..."

    # Carrinhos marcados como abandonados há mais de 7 dias
    expired_carts = Cart.where("updated_at < ?", 7.days.ago)

    # Remove carrinhos
    expired_carts.delete_all

    Rails.logger.info "✔️ #{expired_carts.size} carrinhos removidos."
  end
end
