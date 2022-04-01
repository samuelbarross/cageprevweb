json.array!(@lotacoes) do |lotacao|
  json.extract! lotacao, :id, :codigo, :descricao
  json.url lotacao_url(lotacao, format: :json)
end
