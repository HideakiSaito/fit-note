json.array!(@users) do |user|
  json.extract! user, :id, :provider, :uid, :name, :email, :icon, :oauth_token, :oauth_expires_at
  json.url user_url(user, format: :json)
end
