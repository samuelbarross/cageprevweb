json.array!(@estados) do |estado|
  json.extract! estado, :id, :descricao
  json.url estado_url(estado, format: :json)
end