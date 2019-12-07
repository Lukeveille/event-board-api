class AttendingSerializer < ActiveModel::Serializer
  attributes :id

  has_one :event, serializer: EventSerializer
end
