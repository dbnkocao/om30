class Municipe < ApplicationRecord
  TELEFONE_PATTERN = /\(\d{2}\)\d{4,5}-\d{4}/

  serialize :preferences, JSON
  validates_presence_of :nome, :cpf, :email, :dt_nasc, :telefone
  validates_uniqueness_of :cpf
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :telefone, format: { with: self::TELEFONE_PATTERN }

  validate :cpf_valido
  validate :idade_valida
  validate :last_name

  after_create :notificacao_cadastro
  after_update :notificacao_atualizacao
  has_one_attached :foto

  has_one :endereco
  accepts_nested_attributes_for :endereco

  enum status: [:ativo, :inativo], _default: :ativo

  searchkick text_middle: [:nome, :cpf, :telefone, :dt_nasc, :logradouro, :bairro]

  def search_data
    {
      bairro: endereco.bairro,
      logradouro: endereco.logradouro,
    }
  end

  def foto_url
    return "" unless foto.present?
    Rails.application.routes.url_helpers.rails_blob_url(foto, only_path: true)
  end

  private

  def last_name
    if nome && nome.split.count < 2
      errors.add(:nome, :no_last_name)
    end
  end

  def cpf_valido
    unless CpfUtils.cpf_valido?(cpf)
      errors.add(:cpf, :invalid)
    end
  end

  def idade_valida
    if dt_nasc != nil && (Date.today.year - dt_nasc.year > 150 || Date.today < dt_nasc)
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
