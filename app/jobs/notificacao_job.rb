class NotificacaoJob < ApplicationJob
  queue_as :default

  def perform(municipe, tipo = "cadastro")
    if tipo == "cadastro"
      NotificacaoMailer.cadastro(municipe).deliver_later
      SendSms.new("#{self.nome} você foi cadastrado com o cpf: #{self.cpf} na plataforma.", self.telefone).call
    else
      NotificacaoMailer.atualizacao(municipe).deliver_later
      SendSms.new("#{self.nome} seu status foi atualizado para #{self.status}.", self.telefone).call
    end
  end
end
