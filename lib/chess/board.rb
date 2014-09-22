module Chess
  class Board
    attr_accessor :knight, :rows, :columns
    KNIGHTMOVES =   [2, 1],[2, -1],
                    [1, 2],[1, -2],
                    [-1,2],[-1,-2],
                    [-2,1],[-2,-1] 
    def initialize(position = 'a1')
      @rows = 'a'..'h'
      @columns = 1..8
      @knight=Chess::Piece.new(position, KNIGHTMOVES ) 
    end

    def knight position
     @knight.move(position)
    end

    def each
      ('a'..'d').each { |row|
        (1..4).each { |column|
          yield "#{row}#{column}"
          yield "#{row}#{9-column}"
          yield "#{row.mirror}#{9-column}"
          yield "#{row.mirror}#{column}"
        }
      }
    end
    def get_mirrors row,column
    end
    def select_column position
      position[1,2].to_i
    end
    def select_row position
      position[0,1]
    end
    def valid_moves 
      @knight.possible_moves.select { |move| 
        position = @knight.try_move(move)
        is_position_valid?(select_row(position), select_column(position)) 
      }
    end
    def valid_positions 
      valid_moves.map {|move|
        @knight.try_move(move)
      }
    end

    def is_position_valid? row, column
      @rows.include?(row) && @columns.include?(column)
    end

  end

end
