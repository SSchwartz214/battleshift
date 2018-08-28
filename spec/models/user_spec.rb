require 'rails_helper'

describe User, type: :model do
  context 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:user_token)}
    it {should validate_uniqueness_of(:username)}
  end
end
