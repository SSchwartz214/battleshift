class User < ApplicationRecord
  validates_presence_of :username, :email, :user_token
  validates :password, presence: true, on: :update, allow_blank: true
  validates_uniqueness_of :username
  validates_confirmation_of :password

  has_secure_password
  has_many :user_games
  has_many :games, through: :user_games

  def make_token
    if user_token == '0'
      self.user_token = SecureRandom.urlsafe_base64
    end
    self.save!
    user_token
  end
end
