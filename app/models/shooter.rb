class Shooter
  def initialize(board:, target:)
    @board     = board
    @target    = target
    @message   = ""
  end

  def fire!
    result = {}
    if valid_shot?
      result[:hit] = space.attack!
      if space.contents != nil && space.contents.is_sunk?
        result[:sunk] = true
      end
      result
    else
      raise InvalidAttack.new("Invalid coordinates.")
    end
  end

  def self.fire!(board:, target:)
    new(board: board, target: target).fire!
  end

  def valid_shot?
    board.space_names.include?(target)
  end
  
  private
    attr_reader :board, :target

    def space
      @space ||= board.locate_space(target)
    end
end

class InvalidAttack < StandardError
  def initialize(msg = "Invalid attack.")
    super(msg)
  end
end
