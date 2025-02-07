#class MarkCartAsAbandonedJob < ApplicationJob
#  queue_as :default
class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform
    Rails.logger.info "🛒 Iniciando marcação de carrinhos abandonados..."

    abandoned_carts = Cart.where("updated_at < ?", 3.hours.ago)

    abandoned_carts.update_all(total_price: 0)

    Rails.logger.info "✔️ #{abandoned_carts.size} carrinhos marcados como abandonados."
  end
end
