class Event < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :attendings
  has_many :users, through: :attendings

  validates :name, presence: true
  validates :limit, presence: true
  validates :start, presence: true
  validates :end, presence: true

  def category_name
    return self.category.name
  end

  def users_attending
    users = []
    self.attendings.each do |attending|
      users.push({
        id: attending.user_id,
        full_name: User.find(attending.user_id).full_name
      })
    end
    return users
  end

  def total_events
    return Event.all.where('DATE(start) > ?', Date.today).length
  end
end
