json.extract! order, :id, :number, :total, :state, :payment_id, :created_at, :updated_at
json.url order_url(order, format: :json)
