class AddColumnNomeToMunicipe < ActiveRecord::Migration[6.1]
  def change
    add_column :municipes, :nome, :string
  end
end
