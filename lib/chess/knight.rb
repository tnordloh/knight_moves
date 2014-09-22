module Chess
  class Piece
    attr_reader :position,:possible_moves
    def initialize(position,possible_moves)
      @position,@possible_moves=position,possible_moves
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
      #Position.new((row().offset(coordinate[0])), column+coordinate[1]) 
      "#{(row().offset(coordinate[0]))}#{column+coordinate[1]}"
    end
  end
end
