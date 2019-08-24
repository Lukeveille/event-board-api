class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :limit, :user_id, :category_id, :start, :end, :lat, :long
end
