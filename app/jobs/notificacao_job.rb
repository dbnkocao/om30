class NotificacaoJob < ApplicationJob
  queue_as :default

  def perform(municipe)
    NotificacaoMailer.cadastro(municipe).deliver_later
  end
end
