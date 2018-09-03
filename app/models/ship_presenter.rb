class ShipPresenter
  def initialize(game)
    @game = game
    @board = determine_board
  end

  def determine_board
    if @game.current_turn == "player_1"
      @game.player_1_board.board
    else
      @game.player_2_board.board
    end
  end

  def set_ships(ship_size, start_space, end_space)
    ship = Ship.new(ship_size)
    ship.place(start_space, end_space)
    

  end

  private
  def check_ships
    board.check_board_for_ships
  end
end
