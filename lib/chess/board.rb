module Chess
  class Board
    attr_accessor 

    def initialize(size = 8)
      @rows = 0...size
      @columns = 0...size
      @square=Chess::Square.new()
      @piece=Chess::Knight.new([0,0]) 
    end

    def replace_piece piece,position
      @piece=Chess::Knight.new(@square.to_coordinate(position)) if(piece=="knight")
      @piece=Chess::Bishop.new(@square.to_coordinate(position)) if(piece=="bishop") 
    end

    def set position
      @piece.move(@square.to_coordinate(position))
    end

    def each
      @rows.each { |row| @columns.each { |column| yield @square.to_chess_notation([row,column]) } }
    end

    def valid_moves 
      @piece.possible_moves.select { |move| 
        position = @piece.try_move move
        is_position_valid?(position) 
      }
    end

    def valid_positions 
      valid_moves.map {|move| @square.to_chess_notation(@piece.try_move move) }
    end

    def is_position_valid? position 
      (@rows.include?(position[0])  && @columns.include?(position[1]))
    end

  end

end
