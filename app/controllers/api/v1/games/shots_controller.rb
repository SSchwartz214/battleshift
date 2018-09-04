class Api::V1::Games::ShotsController < ApiController
  before_action :check_headers, :current_turn_check, :winner?

  def create
    game = Game.find(params[:game_id])
    shots = ShotsPresenter.new(game, params[:shot][:target], set_player)
    ship_status = shots.complete_turn(set_user.email)
    render_turn_outcome(ship_status, game)
  end

  private
  def render_turn_outcome(status, game)
    if status != "Invalid coordinates."
      render json: game, message: status
    else
      render json: game, status:400, message: status
    end
  end
end
