json.extract! transaction, :id, :external_id, :description, :raw_description, :amount, :date, :category_id, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
