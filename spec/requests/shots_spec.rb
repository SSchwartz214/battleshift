require 'rails_helper'

describe "Api::V1::Shots" do
  context "POST /api/v1/games/:id/shots" do
    let(:user_1) {
      create(:user,
      username: 'Seth', email: 'sethster@gmail.com',
      password_digest: 's', user_token: 'first',
      status: true)
    }
    let(:user_2) {
      create(:user,
      username: 'Tristan', email: 'tritan@gmail.com',
      password_digest: 's', user_token: 'second',
      status: true)
    }
    let(:player_1_board)   { Board.new(4) }
    let(:player_2_board)   { Board.new(4) }
    let(:sm_ship) { Ship.new(2) }
    # let(:game)    { Game.new(player_1_board: Board.new(4), player_2_board: Board.new(4), player_1_turns: 0, player_2_turns: 0, current_turn: "player_1", player_1_key: user_1.user_token, player_2_key: user_2.user_token)
      # create(:game,
      #   player_1_board: player_1_board,
      #   player_2_board: player_2_board,
      #   player_1_turns: 0, player_2_turns: 0,
      #   current_turn: "player_1",
      #   player_1_key: user_1.user_token, player_2_key: user_2.user_token
      # )
    # }

    it "updates the message and board with a hit" do
      game = Game.create(player_1_board: Board.new(4), player_2_board: Board.new(4), player_1_turns: 0, player_2_turns: 0, current_turn: "player_1", player_1_key: user_1.user_token, player_2_key: user_2.user_token)
      # allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")
      sm_ship.place("A1", "A2")
      ShipPlacer.new(board: player_2_board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2").run
      game.save!

      headers = {"X-API-Key" => user_1.user_token, "CONTENT_TYPE" => "application/json" }
      json_payload = {target: "A1"}.to_json

      post "/api/v1/games/#{game.id}/shots", params: json_payload, headers: headers

      expect(response).to be_success

      game = JSON.parse(response.body, symbolize_names: true)

      expected_messages = "Your shot resulted in a Hit. The player_2's shot resulted in a Miss."
      player_2_targeted_space = game[:player_2_board][:rows].first[:data].first[:status]


      expect(game[:message]).to eq expected_messages
      expect(player_2_targeted_space).to eq("Hit")
    end

    it "updates the message and board with a miss" do
      allow_any_instance_of(AiSpaceSelector).to receive(:fire!).and_return("Miss")

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
