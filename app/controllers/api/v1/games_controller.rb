class Api::V1::GamesController < ActionController::API

  def show
    game = Game.find(params[:id])
    if game != nil
      render json: game
    else
      render status: 400
    end
  end
end
