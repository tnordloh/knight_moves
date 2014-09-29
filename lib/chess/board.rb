module Chess
#Board's purpose is to define the size and shape of the chess board, and to validate moves handed to it from
  #related functions, by determining if returned values are included on the board.
  class Board
    attr_accessor 

    def initialize(size = 8, remove = [])
      @columns = 1..8
      @rows = 'a'..'h'
      @board= {}
      @rows.each { |row| @columns.each { |column| @board["#{row}#{column}"] = Chess::Square.new("#{row}#{column}") } }
      @piece=KNIGHT_MOVES
    end

    def remove_square remove = []
      remove.each {|square| 
        @board.delete(square) 
      }
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
      @board[position].moves.select { |move| is_position_valid?(move) }
    end

    def is_position_valid? position 
      !!@board[position]
    end

  end

end
