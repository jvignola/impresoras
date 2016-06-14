json.array!(@orders) do |order|
  json.extract! order, :id, :user_id, :product_id, :autorizado, :entregado, :cantidad
  json.url order_url(order, format: :json)
end
