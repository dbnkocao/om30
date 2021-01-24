require "rails_helper"

RSpec.describe Endereco, type: :model do
  let(:endereco) { build(:endereco) }

  it "should not be valid without cep" do
    endereco.cep = nil
    expect(endereco).to_not be_valid
  end

  it "should not be valid without logradouro" do
    endereco.logradouro = nil
    expect(endereco).to_not be_valid
  end

  it "should not be valid without numero" do
    endereco.numero = nil
    expect(endereco).to_not be_valid
  end

  it "should not be valid without bairro" do
    endereco.bairro = nil
    expect(endereco).to_not be_valid
  end

  it "should not be valid without municipio" do
    endereco.municipio = nil
    expect(endereco).to_not be_valid
  end

  it "should not be valid without estado" do
    endereco.uf = nil
    expect(endereco).to_not be_valid
  end
end
