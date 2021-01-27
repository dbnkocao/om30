json.extract! municipe, :nome, :email, :cpf, :dt_nasc, :telefone, :status
json.endereco do
  json.cep municipe.endereco.cep
  json.logradouro municipe.endereco.logradouro
  json.numero municipe.endereco.numero
  json.complemento municipe.endereco.complemento
  json.bairro municipe.endereco.bairro
  json.municipio municipe.endereco.municipio
  json.uf municipe.endereco.uf
  json.codigo_ibge municipe.endereco.codigo_ibge
end
json.foto url_for(municipe.foto)
