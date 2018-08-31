class Api::V1::GamesController < ActionController::API
  def show
    game = Game.find(params[:id])
    if game != nil
      render json: game
    else
      render status:400
    end
  end

  def create
    player_1 = User.find_by(user_token: request.headers["HTTP_X_API_KEY"])
    player_2 = User.find_by(email: params["opponent_email"])
    board_1 = Board.new(4)
    board_2 = Board.new(4)
    game = Game.create(player_1_board: board_1, player_2_board: board_2, player_1_turns: 0, player_2_turns: 0, current_turn: 0, player_1_key: player_1.user_token, player_2_key: player_2.user_token)
    render json: game
  end
end
