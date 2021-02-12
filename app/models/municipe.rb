class Municipe < ApplicationRecord
  validates_presence_of :nome, :cpf, :email, :dt_nasc, :telefone
  validates_uniqueness_of :cpf
  validate :cpf_valido
  validate :idade_valida
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  after_create :notificacao_cadastro
  after_update :notificacao_atualizacao
  has_one_attached :foto

  has_one :endereco
  accepts_nested_attributes_for :endereco

  enum status: [:ativo, :inativo], _default: :ativo

  searchkick

  def search_data
    attributes.merge(
      municipio: endereco.try(:municipio),
    )
  end

  private

  def cpf_valido
    unless CpfUtils.cpf_valido?(self.cpf)
      errors.add(:cpf, :invalid)
    end
  end

  def idade_valida
    if self.dt_nasc != nil and Date.today.year - self.dt_nasc.year > 150 || Date.today.year - self.dt_nasc.year < 0
      errors.add(:dt_nasc, :age_out)
    end
  end

  def notificacao_cadastro
    NotificacaoJob.perform_later(self, "cadastro")
  end

  def notificacao_atualizacao
    if self.saved_change_to_status?
      NotificacaoJob.perform_later(self, "atualizacao")
    end
  end
end
