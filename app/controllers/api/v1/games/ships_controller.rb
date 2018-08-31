class Api::V1::Games::ShipsController < ApiController
  def create
    @user = set_user
    @turn = set_player
    ship = Ship.new(params[:ship][:ship_size])
    ship.place(params[:ship][:start_space], params[:ship][:end_space])
    game = Game.find_by(id: params["game_id"])
    game.current_turn = @turn
    if game.current_turn == "player_1"
      ShipPlacer.new(board: game.player_1_board, ship: ship, start_space: ship.start_space, end_space: ship.end_space).run
    else game.current_turn == "player_2"
      ShipPlacer.new(board: game.player_2_board, ship: ship, start_space: ship.start_space, end_space: ship.end_space).run
    end
    game.save!
    render json: game, message: set_message(params[:ship][:ship_size])
  end
end
