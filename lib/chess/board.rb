module Chess
  class Board
    attr_accessor :knight, :rows, :columns

    def initialize(position = 'a1')
      @rows = ('a'..'h').to_a
      @columns = (1..8).to_a
      @piece=Chess::Knight.new(position) 
    end

    def replace_piece piece,position
      @piece=Chess::Knight.new(position) if(piece=="knight")
      @piece=Chess::Bishop.new(position) if(piece=="bishop") 
    end
    def set position
      @piece.move(position)
    end

    def each
      @rows.each { |row| @columns.each { |column| yield "#{row}#{column}" } }
    end

    def select_column position
      position[1,2].to_i
    end

    def select_row position
      position[0,1]
    end

    def valid_moves 
      @piece.possible_moves.select { |move| 
        position = @piece.try_move(move)
        is_position_valid?(select_row(position), select_column(position)) 
      }
    end

    def valid_positions 
      valid_moves.map {|move| @piece.try_move(move) }
    end

    def is_position_valid? row, column
      @rows.include?(row) && @columns.include?(column)
    end

  end

end
