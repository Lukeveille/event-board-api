class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :gravatar_url, :email, :created_at
end
