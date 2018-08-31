class ApiController < ActionController::API

  def set_user
    api_key = request.headers["HTTP_X_API_KEY"]
    @user = User.find_by(user_token: api_key)
    @user
  end

  def set_message(ship_length)
    if ship_length == 3
      "Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2."
    elsif ship_length == 2
      "Successfully placed ship with a size of 2. You have 0 ship(s) to place."
    else
      "YOU IDOT"
    end
  end

  def set_player
    if @user.user_token == ENV["BATTLESHIFT_API_KEY"]
      "player_1"
    else @user.email == ENV["BATTLESHIFT_OPPONENT_EMAIL"]
      "player_2"
    end
  end

  def current_turn_check
    game = Game.find(params[:game_id])
    @user = set_user
    if game.current_turn == set_player
      render json: game, status:400, message: "Invalid move. It's your opponent's turn"
    end
  end
end 
