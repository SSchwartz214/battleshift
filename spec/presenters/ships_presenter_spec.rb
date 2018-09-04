require 'rails_helper'

RSpec.describe ShipsPresenter, type: :model do
  context 'checking ships for damage' do
    xit 'returns a message for ships' do
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
                      current_turn: "player_1"
                      ) }
      big_ship = Ship.new(3)
      big_ship.place("A1", "A3")
      little_ship = Ship.new(2)
      little_ship.place("B1", "C1")
      ShipPlacer.new(board: game.player_1_board, ship: ship, start_space: "A1", end_space: "A2")
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2")
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2")
      ShipPlacer.new(board: board, ship: ship, start_space: "A1", end_space: "A2")
    end
  end
end
