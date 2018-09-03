require 'rails_helper'

describe "Api::V1::Shots" do
  context "POST /api/v1/games/:id/shots" do
    before :each do
      # @user_1 = User.create(username: 'Seth', email: 'sethster@gmail.com', password_digest: 's', user_token: 'first', status: true)
      # @user_2 = User.create(username: 'Tristan', email: 'tritan@gmail.com', password_digest: 's', user_token: 'second', status: true)
      # @game = Game.create(player_1_board: Board.new(4), player_2_board: Board.new(4), player_1_turns: 0, player_2_turns: 0, current_turn: "player_1", player_1_key: @user_1.user_token, player_2_key: @user_2.user_token)
      #
      # @sm_ship = Ship.new(2)
      # @sm_ship.place("A1", "A2")
      # ShipPlacer.new(board: @game.player_1_board,
      #                ship: @sm_ship,
      #                start_space: "A1",
      #                end_space: "A2").run
      # @game.save!
      #
      # @bg_ship = Ship.new(3)
      # @bg_ship.place("B1", "B3")
      # ShipPlacer.new(board: @game.player_1_board,
      #                ship: @bg_ship,
      #                start_space: "B1",
      #                end_space: "B3").run
      # @game.save!
      #
      # @sm_ship = Ship.new(2)
      # @sm_ship.place("A1", "A2")
      # ShipPlacer.new(board: @game.player_2_board,
      #                ship: @sm_ship,
      #                start_space: "A1",
      #                end_space: "A2").run
      # @game.save!
      #
      # @bg_ship = Ship.new(3)
      # @bg_ship.place("B1", "B3")
      # ShipPlacer.new(board: @game.player_1_board,
      #                ship: @bg_ship,
      #                start_space: "B1",
      #                end_space: "B3").run
      # @game.save!
      user_1 = create(:user)
            user_2 = create(:user_2)
            game = create(:game)

            json_payload_1 = { ship_size: 2, start_space: "A1", end_space: "A2" }.to_json
            headers_1 = {"X-API-Key" => user_1.user_token, "CONTENT_TYPE" => "application/json" }
            post "/api/v1/games/#{game.id}/ships", params: json_payload_1, headers: headers_1
            game.save!

            json_payload_2 = { ship_size: 3, start_space: "B1", end_space: "B3" }.to_json
            headers_2 = {"X-API-Key" => user_1.user_token, "CONTENT_TYPE" => "application/json" }
            post "/api/v1/games/#{game.id}/ships", params: json_payload_2, headers: headers_2
            game.save!

            json_payload_3 = { ship_size: 2, start_space: "A1", end_space: "A2" }.to_json
            headers_3 = {"X-API-Key" => user_2.user_token, "CONTENT_TYPE" => "application/json" }
            post "/api/v1/games/#{game.id}/ships", params: json_payload_3, headers: headers_3
            game.save!

            json_payload_4 = { ship_size: 3, start_space: "B1", end_space: "B3" }.to_json
            headers_4 = {"X-API-Key" => user_2.user_token, "CONTENT_TYPE" => "application/json" }
            post "/api/v1/games/#{game.id}/ships", params: json_payload_4, headers: headers_4
            game.save!
      

    end

    it "updates the message and board with a hit" do

      headers = {"X-API-Key" => @user_1.user_token, "CONTENT_TYPE" => "application/json" }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{@game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)
# require "pry"; binding.pry
      expected_messages = "Your shot resulted in a Hit. The player_2's shot resulted in a Miss."
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Hit")
    end

    it "updates the message and board with a miss" do
      headers = { "CONTENT_TYPE" => "application/json" }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Miss. The player_2's shot resulted in a Miss."
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Miss")
    end

    it "updates the message but not the board with invalid coordinates" do
      player_1_board = Board.new(1)
      player_2_board = Board.new(1)
      game = create(:game, player_1_board: player_1_board, player_2_board: player_2_board)

      headers = { "CONTENT_TYPE" => "application/json" }
      json_payload = {target: "B1"}.to_json
      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      game = JSON.parse(response.body, symbolize_names: true)
      expect(game[:message]).to eq "Invalid coordinates."
    end

  end
end
