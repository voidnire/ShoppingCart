class MarkCartAsAbandonedJob
  include Sidekiq::Job

  def perform
    Rails.logger.info "🛒 Iniciando limpeza de carrinhos abandonados..."

    # 1️⃣ Marcar como "abandonado" carrinhos sem interação há mais de 3 horas
    Cart.where("updated_at < ?", 3.hours.ago).update_all(total_price: 0)

    # 2️⃣ Remover carrinhos sem interação há mais de 7 dias
    Cart.where("updated_at < ?", 7.days.ago).delete_all

    Rails.logger.info "✔️ Limpeza de carrinhos concluída!"
  end
end
