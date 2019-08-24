class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :attendings
  has_many :users, through: :attendings
end
