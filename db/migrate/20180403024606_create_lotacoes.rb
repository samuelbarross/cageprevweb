class CreateLotacoes < ActiveRecord::Migration
  def change
    create_table :lotacoes do |t|
      t.string :codigo, limit: 20
      t.string :descricao

      t.timestamps
    end
  end
end
