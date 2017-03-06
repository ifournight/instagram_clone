json.extract! user, :id, :name, :email, :website, :intro, :created_at, :updated_at
json.url user_url(user, format: :json)
