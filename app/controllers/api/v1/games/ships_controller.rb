class Api::V1::Games::ShipsController < ApiController
  def create
    @user = set_user
    ship = Ship.new(params[:ship][:ship_size])
    ship.place(params[:ship][:start_space], params[:ship][:end_space])
    game = Game.find_by(id: params["game_id"])
    current_user = game.users.find_by(user_token: @user.user_token)
    ShipPlacer.new(board: game.player_1_board, ship: ship, start_space: ship.start_space, end_space: ship.end_space).run
    render json: game, message: set_message(params[:ship][:ship_size])
  end
end
