class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.string :codigo, limit: 10
      t.string :descricao
      t.string :uf, limit: 2

      t.timestamps
    end
  end
end
