class CreateDependentes < ActiveRecord::Migration
    def change
        create_table :dependentes do |t|
            t.references :participante, index: true
            t.references :user, index: true
            t.string :codigo, limit: 40
            t.string :nome
            t.integer :sexo
            t.date :data_nascimento
            t.integer :parentesco
            t.boolean :invalido

            t.timestamps
        end
    end
end