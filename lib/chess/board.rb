module Chess
  class Board
    attr_accessor 

    def initialize(size = 8)
      @columns = 1..8
      @rows = 'a'..'h'
      @board= {}
      @rows.each { |row| @columns.each { |column| @board["#{row}#{column}"] = Chess::Square.new("#{row}#{column}") } }
      @piece=KNIGHT_MOVES
    end

    def replace_piece piece
      @piece=piece
    end

    def set position
      @board[position].add_piece(@piece)
    end

    def each
      @board.values.each { |square| yield square.position }
    end

    def valid_positions position 
      set(position)
      @board[position].moves.select { |move| 
        is_position_valid?(move) 
      }
    end

    def is_position_valid? position 
      !!@board[position]
    end

  end

end
