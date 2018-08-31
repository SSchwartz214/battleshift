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

end
