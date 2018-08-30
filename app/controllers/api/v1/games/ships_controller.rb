class Api::V1::Games::ShipsController < ApiController
  def create
    ship = Ship.new(params[:ship][:ship_size])
    ship.place(params[:ship][:start_space], params[:ship][:end_space])
    game = Game.find_by(id: params["game_id"])
    ShipPlacer.new(board: game.player_1_board, ship: ship, start_space: ship.start_space, end_space: ship.end_space).run
    render json: game, message: "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
  end
end
