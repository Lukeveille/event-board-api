class User < ApplicationRecord
  has_many :events
  has_many :attendings
  has_many :events, through: :attendings
end
