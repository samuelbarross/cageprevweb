json.array!(@participantes) do |participante|
  json.extract! participante, :id, :estado_id, :lotacao_id, :matricula, :nome, :nome_pai, :nome_mae, :nome_conjugue, :sexo, :naturalidade, :nacionalidade, :estado_civil, :data_nascimento, :cpf, :rg, :orgao_expedidor, :data_expedicao, :logradouro, :numero, :complemento, :bairro, :cidade, :cep, :data_posse, :cargo, :telefone_residencial, :telefone_celular, :email
  json.url participante_url(participante, format: :json)
end
