class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :attendings
  has_many :users, through: :attendings

  validates :name, presence: true
  validates :limit, presence: true
  validates :start, presence: true
  validates :end, presence: true
end
