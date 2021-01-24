class Endereco < ApplicationRecord
  belongs_to :municipe
  validates_presence_of :cep, :logradouro, :numero, :bairro, :municipio, :uf
end
