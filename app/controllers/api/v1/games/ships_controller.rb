class Api::V1::Games::ShipsController < ApiController
  before_action :set_user

  def create
    game = Game.find_by(id: params["game_id"])
    game.current_turn = set_player
    presenter = ShipsPresenter.new(game)
    presenter.set_ships(params[:ship_size], params[:start_space], params[:end_space])
    render json: game, message: set_message(params[:ship][:ship_size])
  end
end
