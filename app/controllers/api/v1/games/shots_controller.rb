class Api::V1::Games::ShotsController < ApiController
  before_action :current_turn_check
  # , :winner?

  def create
    game = Game.find(params[:game_id])
    @user = set_user
    # player_ship_1 =
    # player_ship_2
    if set_player == "player_1"
      game.current_turn = set_player
      turn_processor = TurnProcessor.new(game, params[:shot][:target])
    else
      game.current_turn = set_player
      turn_processor = TurnProcessor.new(game, params[:shot][:target])
    end
    if turn_processor.run! == true
      game.save!
      render json: game, message: turn_processor.message
    else
      render json: game, status:400, message: "Invalid coordinates"
    end
  end
end
