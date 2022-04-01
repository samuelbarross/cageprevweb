class CreateParticipantes < ActiveRecord::Migration
    def change
        create_table :participantes do |t|
            t.references :estado, index: true
            t.references :lotacao, index: true
            t.references :user, index: true
            t.string :matricula, limit: 25
            t.string :nome, limit: 60
            t.string :nome_pai, limit: 60
            t.string :nome_mae, limit: 60
            t.string :nome_conjugue, limit: 60
            t.integer :sexo
            t.string :naturalidade, limit: 40
            t.string :nacionalidade, limit: 40
            t.integer :estado_civil
            t.date :data_nascimento
            t.string :cpf, limit: 11
            t.string :rg, limit: 20
            t.string :orgao_expedidor, limit: 20
            t.date :data_expedicao
            t.string :logradouro, limit: 100
            t.string :numero, limit: 10
            t.string :complemento, limit: 100
            t.string :bairro, limit: 40
            t.string :cidade, limit: 40
            t.string :cep, limit: 20
            t.date :data_posse
            t.string :cargo, limit: 60
            t.string :telefone_residencial, limit: 20
            t.string :telefone_celular, limit: 20
            t.string :email, limit: 60

            t.timestamps
        end
    end
end