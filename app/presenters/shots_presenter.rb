class ShotsPresenter
  attr_reader :game, :target, :player, :turn_processor
  include ShipChecker

  def initialize(game, target, player)
    @game = game
    @target = target
    @player = player
    @turn_processor = TurnProcessor.new(game, target)
  end

  def fire_shot
    game.current_turn = player
    turn_processor.run!
  end

  def complete_turn(email)
    if player == "player_1" && fire_shot
      turn_processor.message + check_ship_status(game, game.player_2_board.board, email)
    elsif player == "player_2" && fire_shot
      turn_processor.message + check_ship_status(game, game.player_2_board.board, email)
    else
      turn_processor.message
    end
  end
end
