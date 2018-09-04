require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'validations' do
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

    it "should have keys and boards" do
      expect(game.player_1_board.board.length).to eq(4)
      expect(game.player_2_board.board.length).to eq(4)
      expect(game.player_1_key).to eq(user_1.user_token)
      expect(game.player_2_key).to eq(user_2.user_token)
      expect(game.player_1_turns).to eq(0)
      expect(game.player_2_turns).to eq(0)
      expect(game.current_turn).to eq("start")
      expect(game.winner).to eq(nil)
    end
  end

  context 'Relationships' do
    it { should have_many(:user_games) }
    it { should have_many(:users).through(:user_games) }
  end
end
