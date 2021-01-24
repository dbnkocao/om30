class Municipe < ApplicationRecord
  validates_presence_of :nome, :cpf, :email, :dt_nasc, :telefone
  validates_uniqueness_of :cpf
  validate :cpf_valido
  validate :idade_valida
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one :endereco

  private

  def cpf_valido
    unless CpfUtils.cpf_valido?(self.cpf)
      errors.add(:cpf, "CPF Inválido!")
    end
  end

  def idade_valida
    if self.dt_nasc != nil and Date.today.year - self.dt_nasc.year > 150 || Date.today.year - self.dt_nasc.year < 0
      errors.add(:dt_nasc, "Data de Nascimento inválida, a idade do Municipe deve ficar entre 0 e 150")
    end
  end
end
