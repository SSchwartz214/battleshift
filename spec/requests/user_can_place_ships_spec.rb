require 'rails_helper'

describe 'POST /api/v1/games/:id/ships/1' do
  context 'a user within an existing game' do
    it 'can place ships' do

      user_1 = User.create(username: 'Seth', email: 'sethster@gmail.com', password_digest: 's', user_token: 'first', status: true)
      user_2 = User.create(username: 'Tristan', email: 'tritan@gmail.com', password_digest: 's', user_token: 'second', status: true)
      game = Game.create(player_1_board: Board.new(4), player_2_board: Board.new(4), player_1_turns: 0, player_2_turns: 0, current_turn: "player_1", player_1_key: user_1.user_token, player_2_key: user_2.user_token)
      ship = Ship.new(3)
      ship.place("A1", "A3")
      ShipPlacer.new(board: game.player_1_board, ship: ship, start_space: ship.start_space, end_space: ship.end_space).run
      game.save!

      json_payload = {
      ship_size: 3,
      start_space: "A1",
      end_space: "A3"
      }.to_json

      headers = {"X-API-Key" => user_1.user_token, "CONTENT_TYPE" => "application/json" }

      post "/api/v1/games/#{game.id}/ships", params: json_payload, headers: headers

      expect(response.status).to be(200)
      expect(JSON.parse(response.body, symbolize_names: true)[:message]).to eq("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")
      expect(Game.last.player_1_board.board[0][0]['A1'].contents).to be_a(Ship)
    end
  end
end
