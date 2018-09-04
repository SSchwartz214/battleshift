require 'rails_helper'

RSpec.describe UserGame, type: :model do
  let(:user_1) {
    User.create(
      username: 'Bob',
      email: 'hoskins@gmail.com',
      password: 'b',
      user_token: '007',
      status: true,
      identifier: '007'
      ) }
  let(:user_2) {
    User.create(
      username: 'Sob',
      email: 'soskins@gmail.com',
      password: 's',
      user_token: '009',
      status: true,
      identifier: 'soskins@gmail.com'
      ) }
  let(:game) {
    Game.create!( player_1_board: Board.new(4),
                  player_2_board: Board.new(4),
                  player_1_turns: 0,
                  player_2_turns: 0,
                  winner: nil,
                  player_1_key: user_1.user_token,
                  player_2_key: user_2.user_token,
                  current_turn: "start")
  }
  let(:user_game) {
    UserGame.create(
      user_id: user_1.id,
      game_id: game.id
    )
  }
  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:game_id) }
  end
  context 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:game) }
  end
end
