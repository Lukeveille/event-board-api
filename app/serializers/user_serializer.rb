class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :created_at
end
