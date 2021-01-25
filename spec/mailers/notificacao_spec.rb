require "rails_helper"

RSpec.describe NotificacaoMailer, type: :mailer do
  describe "cadastro" do
    before do
      @municipe = create(:municipe)
      @mail = NotificacaoMailer.cadastro(@municipe)
    end

    it "renders the headers" do
      expect(@mail.to).to include(@municipe.email)
    end

    it "body have municipe nome" do
      expect(@mail.body.encoded).to match(@municipe.nome)
    end

    it "body have municipe cpf" do
      expect(@mail.body.encoded).to match(@municipe.cpf)
    end

    it "body have municipe email" do
      expect(@mail.body.encoded).to match(@municipe.email)
    end

    it "body have municipe telefone" do
      expect(@mail.body.encoded).to match(@municipe.telefone)
    end
  end
end
