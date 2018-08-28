class User < ApplicationRecord
  validates_presence_of :username, :email, :password, :user_token
  validates_uniqueness_of :username
  validates_confirmation_of :password

  has_secure_password

  def make_token
    if user_token == '0'
      self.user_token = SecureRandom.urlsafe_base64
    end
    self.save!
    user_token
  end
end
