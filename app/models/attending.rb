class Attending < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates_uniqueness_of :user_id, scope: [:event_id]
end
