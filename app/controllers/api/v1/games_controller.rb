class Api::V1::GamesController < ActionController::API
  include GameInitiator

  def show
    game = Game.find_by(id: params[:id])
    if game != nil
      render json: game
    else
      render status:400
    end
  end

  def create
    if validate_users(request.headers["HTTP_X_API_KEY"], params["opponent_email"])
      game = Game.create(create_game_params) if Game.create(create_game_params)
      render json: game
    else
      render json: {message: "Invalid user, please sign up for an account"}, status:401
    end
  end
end
