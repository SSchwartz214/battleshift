require 'rails_helper'

describe Board, type: :model do
  it 'finds ships within itself' do
    board = Board.new(4)
    big_ship = Ship.new(3)
    lil_boat = Ship.new(2)

    ShipPlacer.new(
      board: board,
      ship: big_ship,
      start_space: 'A1',
      end_space: 'A3'
    ).run

    ShipPlacer.new(
      board: board,
      ship: lil_boat,
      start_space: 'B1',
      end_space: 'C1'
    ).run

    expect(board.check_board_for_ships).to eq([big_ship, lil_boat])
  end
end
