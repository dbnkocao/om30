class NotificacaoJob < ApplicationJob
  queue_as :default

  def perform(municipe, tipo = "cadastro")
    if tipo == "cadastro"
      NotificacaoMailer.cadastro(municipe).deliver_later
      SendSms.new("#{municipe.nome} você foi cadastrado com o cpf: #{municipe.cpf} na plataforma.", municipe.telefone).call
    else
      NotificacaoMailer.atualizacao(municipe).deliver_later
      SendSms.new("#{municipe.nome} seu status foi atualizado para #{municipe.status}.", municipe.telefone).call
    end
  end
end
