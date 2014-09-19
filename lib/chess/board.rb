module Chess
  class Board
    attr_accessor :knight, :rows, :columns
    KNIGHTMOVES =   [2, 1],[2, -1],
                    [1, 2],[1, -2],
                    [-1,2],[-1,-2],
                    [-2,1],[-2,-1] 
    def initialize(position = nil)
      @rows = 'a'..'h'
      @columns = 1..8
      knight(position)
    end

    def knight position
     @knight = Piece.new(position, KNIGHTMOVES ) 
    end

    def valid_moves 
      @knight.possible_moves.select { |move| 
        is_position_valid?(@knight.move(move)) 
      }
    end
    def valid_positions 
      valid_moves.map {|move|
        @knight.move(move).coordinate()
      }
    end

    def is_position_valid? position
      @rows.include?(position.row) && @columns.include?(position.column)
    end

  end


  Piece = Struct.new(:position, :possible_moves) {
    def row
      position[0,1]
    end
    def column
      position[1,1].to_i
    end
    def move coordinate
      Position.new((row().offset(coordinate[0])), column+coordinate[1]) 
    end
  } 


  Position = Struct.new(:row,:column) {
    def coordinate
      return "#{row}#{column}"
    end
  }

end
