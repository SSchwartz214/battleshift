module ShipChecker
  def check_ship_status(game, board, email)
    ships = []
    board.each do |row|
      row.each do |line|
        line.each_pair do |key, value|
          ships << value.contents if value.contents != nil
        end
      end
    end
    sunken_ship?(game, ships.uniq!, email)
  end

  def sunken_ship?(game, ships, email)
    message = ""
    require "pry"; binding.pry
    if ships.all? { |ship| ship.is_sunk? }
      game.winner = email
      game.save!
      message << " Game over."
    end
    message
  end
end
