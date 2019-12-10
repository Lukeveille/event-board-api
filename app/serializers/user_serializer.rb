class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :profile_pic, :email, :created_at
end
