class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_link, :limit, :user_id, :category_id, :start, :end, :lat, :long
end
