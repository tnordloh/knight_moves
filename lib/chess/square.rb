module Chess
  class Square
    attr_reader :position

    def initialize position
      @position=position
    end

    def to_coordinate position = @position 
      x,y = position.scan(/\-?\d+|[a-z]+/)
      [(x.ord - 'a'.ord),y.to_i-1]
    end

    def to_chess_notation coordinate 
      "#{(coordinate[0]+'a'.ord).chr}#{coordinate[1]+1}"
    end

    def add_piece piece
      @piece=piece
    end

    def moves
      @piece.map {|coordinate| move coordinate }
    end

    def split_chess_notation
      fail "Bad notation" unless @position =~ /\A([a-h])(-?\d+)\z/
      [$1, $2]
    end

    def move moves = {:up => 0, :right => 0 }
      fields = split_chess_notation
      up=(moves[:up] || 0 ) - (moves[:down] || 0)
      right=(moves[:right] || 0 ) - (moves[:left] || 0)
      #puts "up #{moves[:up]} puts right #{moves[:right]}"
      "#{(fields[0].ord+right).chr}#{(fields[1].to_i+up)}"
    end

  end
end
