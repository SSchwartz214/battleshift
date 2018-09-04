require 'rails_helper'

RSpec.describe Shooter, type: :model do
  it "should filter invalid shots" do
    board = Board.new(4)
    coordinate = '11'
    shooter = Shooter.new(board: board, target: coordinate)

    expect(shooter.valid_shot?).to be_falsy
  end

  it "allows valid shots to be fired" do
    board = Board.new(4)
    coordinate = 'A1'
    shooter = Shooter.new(board: board, target: coordinate)

    expect(shooter.valid_shot?).to be_truthy
  end
end
