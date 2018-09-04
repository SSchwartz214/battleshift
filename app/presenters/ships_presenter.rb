class ShipsPresenter
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def set_ships(ship_size, start_space, end_space)
    ship = Ship.new(ship_size)
    ship.place(start_space, end_space)
    place_on_board(ship)
  end

  def place_on_board(ship)
    if game.current_turn == "player_1"
      ShipPlacer.new(board: game.player_1_board, ship: ship, start_space: ship.start_space, end_space: ship.end_space).run
    else game.current_turn == "player_2"
      ShipPlacer.new(board: game.player_2_board, ship: ship, start_space: ship.start_space, end_space: ship.end_space).run
    end
    game.save!
  end
end
