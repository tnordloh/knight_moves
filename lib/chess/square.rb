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
    def position
      @position
    end
    def add_piece piece
      @piece=piece
    end
    def moves
      @piece.map {|coordinate| 
        send(coordinate[0], *coordinate[1]) 
      }
    end
    def split_chess_notation
      fail "Bad notation" unless @position =~ /\A([a-h])(-?\d+)\z/
      [$1, $2]
    end
    def move up = 0, right = 0
      fields = split_chess_notation
      "#{(fields[0].ord+up).chr}#{(fields[1].to_i+right)}"
    end
    def up_right up = 1, right = 1
      move up,right
    end
    def right count = 1
      up_right count, 0
    end
    def left count = 1
      up_right -count, 0
    end
    def up count = 1
      up_right 0, count
    end
    def down count = 1
      up_right 0,-count
    end
    def down_right down = 1, right = 1
      up_right(-down,right)
    end
    def up_left up = 1, left = 1
      up_right(up,-left)
    end
    def down_left down = 1, left = 1
      up_right(-down,-left)
    end
  end
end
