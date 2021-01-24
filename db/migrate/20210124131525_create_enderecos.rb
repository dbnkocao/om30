class CreateEnderecos < ActiveRecord::Migration[6.1]
  def change
    create_table :enderecos do |t|
      t.references :municipe, null: false, foreign_key: true
      t.string :cep
      t.string :logradouro
      t.string :complemento
      t.string :bairro
      t.string :municipio
      t.string :uf
      t.string :numero
      t.string :codigo_ibge

      t.timestamps
    end
  end
end
