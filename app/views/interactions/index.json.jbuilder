json.array!(@interactions) do |interaction|
  json.extract! interaction, :id, :user_id, :product_id, :pregunta, :mensaje
  json.url interaction_url(interaction, format: :json)
end
