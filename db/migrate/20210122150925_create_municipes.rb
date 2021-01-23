class CreateMunicipes < ActiveRecord::Migration[6.1]
  def change
    create_table :municipes do |t|
      t.string :cpf
      t.string :email
      t.date :dt_nasc
      t.string :telefone
      t.integer :status

      t.timestamps
    end
  end
end
