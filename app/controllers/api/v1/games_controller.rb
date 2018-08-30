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
    render json: Game.create(player_1_board: board_1, player_2_board: board_2, player_1_turns: 0, player_2_turns: 0, current_turn: 0)
  end
end
