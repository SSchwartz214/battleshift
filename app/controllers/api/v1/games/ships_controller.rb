class Api::V1::Games::ShipsController < ApiController
  before_action :set_user

  def create
    game = Game.find_by(id: params["game_id"])
    presenter = ShipPresenter.new(game)
    ship = Ship.new(params[:ship][:ship_size])
    ship.place(params[:ship][:start_space], params[:ship][:end_space])
    start_ship_placement(game)
    game.current_turn = set_player
    if game.current_turn == "player_1"
      ShipPlacer.new(board: game.player_1_board, ship: ship, start_space: ship.start_space, end_space: ship.end_space).run
    else game.current_turn == "player_2"
      ShipPlacer.new(board: game.player_2_board, ship: ship, start_space: ship.start_space, end_space: ship.end_space).run
    end
    game.save!
    render json: game, message: set_message(params[:ship][:ship_size])
  end
end
