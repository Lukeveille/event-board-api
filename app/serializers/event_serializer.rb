class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image_link, :limit, :category_name, :start, :end, :lat, :long, :total_events, :users_attending

  has_one :user
end
