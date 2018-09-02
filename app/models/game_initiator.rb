module GameInitiator
  def validate_users(user_1_token, user_2_email)
    if status_confirmation(user_1_token, user_2_email) == true
      @user_1 = User.find_by(user_token: user_1_token)
      @user_2 = User.find_by(email: user_2_email)
    end
  end

  def status_confirmation(token, email)
    user_1 = User.where(user_token: token) if token != "0"
    user_2 = User.where(email: email)
    if user_1 != [] && user_2 != [] && user_1 != nil && user_1[0].status == true && user_2[0].status == true
      return true
    end
  end

  def create_game_params
    if @user_1 != nil || @user_2 != nil
      {
        player_1_board: Board.new(4),
        player_2_board: Board.new(4),
        player_1_turns: 0,
        player_2_turns: 0,
        current_turn: 0,
        player_1_key: @user_1.user_token,
        player_2_key: @user_2.user_token
      }
    end
  end
end
