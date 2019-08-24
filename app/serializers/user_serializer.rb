class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :password_digest, :created_at
end
