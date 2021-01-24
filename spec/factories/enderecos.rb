FactoryBot.define do
  factory :endereco do
    municipe
    cep { FFaker::AddressBR.zip_code }
    logradouro { FFaker::AddressBR.street }
    complemento { nil }
    bairro { FFaker::AddressBR.neighborhood }
    municipio { FFaker::AddressBR.city }
    uf { FFaker::AddressBR.state_abbr }
    numero { rand(1..2000) }
    codigo_ibge { nil }
  end
end
