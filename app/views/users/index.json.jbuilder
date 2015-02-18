json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :user_name, :email, :phone_num, :password_digest
  json.url user_url(user, format: :json)
end
