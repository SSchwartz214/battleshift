class TurnProcessor
  def initialize(game, target)
    @game   = game
    @target = target
    @messages = []
  end

  def run!
    begin
      attack_opponent
      if @game.player_2_key == nil
        ai_attack_back
      end
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

  def ai_attack_back
    result = AiSpaceSelector.new(player.board).fire!
    @messages << "The player_2's shot resulted in a #{result}."
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

  # def check_for_ships(board)
  #   ships = []
  #   board.each do |row|
  #     row.each do |line|
  #       line.each_pair do |key, value|
  #         ships << value.contents if value.contents != nil
  #       end
  #     end
  #   end
  #   ships.uniq!
  # end
end
