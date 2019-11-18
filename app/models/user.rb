class User < ApplicationRecord
  has_secure_password

  has_many :events
  has_many :attendings
  has_many :events, through: :attendings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  def full_name
    return "#{self.first_name} #{self.last_name}"
  end

  def gravatar_url
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "https://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
