module Chess
  #Square's purpose is to encapsulate all math on chess board coordinates, by 
  #doing appropriate 'math' on chess notation.  For example, moving a knight 
  #from "a1" to "c2" actually shifts the knight two spaces to the right, and 
  #one space up.  Math This code handles that movement, and hands back an 
  #appropriate response.  Square is totally unaware of the rest of the board, 
  #so it can return coordinates that are off the board.  The board will handle 
  #actual validation of the return values from Square.  This is intentional, 
  #to enable "board" to black out squares arbitrarily, without requiring 
  #changes to the "square" code
  class Square
    attr_reader :position
    attr_accessor :blocked
    def initialize position
      @position=position
      @blocked=false
    end

    def add_piece piece
      @piece=piece
    end

    def move moves = {:up => 0, :right => 0 }
      row,column = split_chess_notation
      up=(moves[:up] || 0 ) - (moves[:down] || 0)
      right=(moves[:right] || 0 ) - (moves[:left] || 0)
      "#{(row.ord+right).chr}#{(column+up)}"
    end

    def moves
      @piece.map {|coordinate| move coordinate }
    end

    private
    def to_coordinate position = @position 
      row,column = split_chess_notation position
      [(row.ord - 'a'.ord),column-1]
    end

    def to_chess_notation coordinate 
      "#{(coordinate[0]+'a'.ord).chr}#{coordinate[1]+1}"
    end

    def split_chess_notation position = @position
      fail "Bad notation" unless position =~ /\A([a-h])(-?\d+)\z/
      [$1, $2.to_i]
    end

  end
end
