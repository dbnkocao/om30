class MunicipeSerializer < ActiveModel::Serializer
  attributes :id, :nome, :cpf, :telefone, :dt_nasc, :endereco_attributes, :foto

  def endereco_attributes
    {
      id: object.endereco.id,
      cep: object.endereco.cep,
      logradouro: object.endereco.logradouro,
      numero: object.endereco.numero,
      complemento: object.endereco.complemento,
      bairro: object.endereco.bairro,
      cidade: object.endereco.municipio,
      estado: object.endereco.uf,
      estado: object.endereco.codigo_ibge,
    }
  end

  def foto
    Rails.application.routes.url_helpers.rails_blob_url(object.foto, only_path: true)
  end
end
