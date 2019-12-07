class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_link, :limit, :category_name, :start, :end, :lat, :long, :users_attending, :user_id

  belongs_to :user
end
