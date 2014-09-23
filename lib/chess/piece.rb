module Chess
  class Piece
    attr_reader :position,:possible_moves
    def initialize(position)
      @position=position
      post_initialize
    end
    def post_initialize
      nil
    end
    def row
      position[0,1]
    end
    def column
      position[1,1].to_i
    end
    def move position
      @position = position
    end
    def try_move coordinate
      "#{(row().offset(coordinate[0]))}#{column+coordinate[1]}"
    end
  end
end
