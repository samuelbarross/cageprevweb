json.array!(@dependentes) do |dependente|
  json.extract! dependente, :id, :participante_id, :codigo, :nome, :sexo, :data_nascimento, :parentesco, :invalido
  json.url dependente_url(dependente, format: :json)
end
