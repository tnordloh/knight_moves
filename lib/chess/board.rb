module Chess
  class Board
    attr_accessor :knight
    KNIGHTMOVES =   [2, 1],[2, -1],
                    [1, 2],[1, -2],
                    [-1,2],[-1,-2],
                    [-2,1],[-2,-1] 
    def initialize()
      @rows = 'a'..'h'
      @columns = 1..8
    end

    def knight
      @knight.position
    end
    def knight position
     @knight = Piece.new(position, KNIGHTMOVES ) 
    end
    def valid_moves 
      @knight.possible_moves.select { |move| 
        p=Position.new((@knight.row().offset(move[0])), @knight.column+move[1]) 
        is_position_valid?(p) 
      }
    end
    def is_position_valid? position
      @rows.include?(position.row) && @columns.include?(position.column)
    end
    def offset_row row,offset
      (row.ord+offset).chr
    end
  end
  Piece = Struct.new(:position, :possible_moves) {
    def row
      position[:row]
    end
    def column
      position[:column]
    end
  } 
  Position = Struct.new(:row,:column)
end
