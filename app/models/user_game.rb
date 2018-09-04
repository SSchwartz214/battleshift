class UserGame < ApplicationRecord
  validates_presence_of :user_id
  validates_presence_of :game_id
  
  belongs_to :user
  belongs_to :game
end
