class Api::V1::Games::ShipsController < ApiController
  def create
    game = Game.find_by(id: params["game_id"])
    ship = Ship.new(params[:ship][:ship_size])
    ship_placer = ShipPlacer.new(board: game.player_1_board, ship: ship, start_space: params[:start_space], end_space: params[:end_space]).run
    render json: game, message: "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
  end

  def index
  end
end
