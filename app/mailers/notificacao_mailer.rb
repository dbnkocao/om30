class NotificacaoMailer < ApplicationMailer
  def cadastro(municipe)
    @municipe = municipe
    mail to: municipe.email, subject: "Cadastro de pessoa."
  end

  def atualizacao(municipe)
    @municpe = municipe
    mail to: municipe.email, subject: "Cadastro atualizado."
  end
end
