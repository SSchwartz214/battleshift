class TurnProcessor
  def initialize(game, target)
    @game   = game
    @target = target
    @messages = []
  end

  def run!
    begin
      attack_opponent
      @game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def attack_opponent
    result = Shooter.fire!(board: opponent.board, target: target)
    @messages << "Your shot resulted in a #{result[:hit]}."
    @messages << "Battleship sunk." if result[:sunk]
  end

  def player
    Player.new(game.player_1_board)
  end

  def opponent
    if game.player_1_turns == game.player_2_turns
      game.player_1_turns += 1
      Player.new(game.player_2_board)
    else
      game.player_2_turns += 1
      Player.new(game.player_1_board)
    end
  end
end
