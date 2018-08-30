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
    board_1 = Board.new(4)
    board_2 = Board.new(4)
    new_game = Game.create(player_1_board: board_1, player_2_board: board_2)
    render json: new_game
  end
end
