json.array!(@participantes) do |participante|
  json.extract! participante, :id, :nome
  json.url participante_url(participante, format: :json)
end