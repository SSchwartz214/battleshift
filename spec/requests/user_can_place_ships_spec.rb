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
    it 'can place a second ship' do
      user_1 = create(:user)
      user_2 = create(:user_2)
      game = create(:game)

      json_payload_1 = { ship_size: 3, start_space: "A1", end_space: "A3" }.to_json
      headers_1 = {"X-API-Key" => user_1.user_token, "CONTENT_TYPE" => "application/json" }
      post "/api/v1/games/#{game.id}/ships", params: json_payload_1, headers: headers_1
      game.save!

      json_payload_2 = { ship_size: 2, start_space: "B1", end_space: "C1" }.to_json
      headers_2 = {"X-API-Key" => user_1.user_token, "CONTENT_TYPE" => "application/json" }
      post "/api/v1/games/#{game.id}/ships", params: json_payload_2, headers: headers_2
      game.save!

      expect(response.status).to be(200)
      game_data = JSON.parse(response.body, symbolize_names: true)

      expect(game_data[:message]).to eq("Successfully placed ship with a size of 2. You have 0 ship(s) to place.")
      expect(Game.last.player_1_board.board[1][0]['B1'].contents).to be_a(Ship)
    end
    it 'cannot place a third ship' do
      user_1 = create(:user)
      user_2 = create(:user_2)
      game = create(:game)

      json_payload_1 = { ship_size: 3, start_space: "A1", end_space: "A3" }.to_json
      headers_1 = {"X-API-Key" => user_1.user_token, "CONTENT_TYPE" => "application/json" }
      post "/api/v1/games/#{game.id}/ships", params: json_payload_1, headers: headers_1
      game.save!

      json_payload_2 = { ship_size: 2, start_space: "B1", end_space: "C1" }.to_json
      headers_2 = {"X-API-Key" => user_1.user_token, "CONTENT_TYPE" => "application/json" }
      post "/api/v1/games/#{game.id}/ships", params: json_payload_2, headers: headers_2
      game.save!
      binding.pry

      json_payload_3 = { ship_size: 2, start_space: "B2", end_space: "C2" }.to_json
      headers_3 = {"X-API-Key" => user_1.user_token, "CONTENT_TYPE" => "application/json" }
      post "/api/v1/games/#{game.id}/ships", params: json_payload_3, headers: headers_3
      game.save!

      expect(response.status).to eq(200)
      expect(response.message).to eq("Ships already placed.")
    end
  end
end
