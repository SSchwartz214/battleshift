class Api::V1::Games::ShotsController < ApiController
  include ShipChecker
  before_action :check_headers, :current_turn_check, :winner?

  def create
    game = Game.find(params[:game_id])
    @user = set_user
    if set_player == "player_1"
      game.current_turn = set_player
      turn_processor = TurnProcessor.new(game, params[:shot][:target])
    else
      game.current_turn = set_player
      turn_processor = TurnProcessor.new(game, params[:shot][:target])
    end
    if turn_processor.run! == true
      if set_player == "player_1"
        @addon = check_ship_status(game, game.player_2_board.board, @user.email)
      else
        @addon = check_ship_status(game, game.player_1_board.board, @user.email)
      end
      @whole = turn_processor.message + @addon
      render json: game, message: @whole
    else
      render json: game, status:400, message: "Invalid coordinates"
    end
  end
end
