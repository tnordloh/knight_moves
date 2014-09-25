module Chess
  class Square
    def to_coordinate position 
      x,y = position.scan(/\-?\d+|[a-z]+/)
      [(x.ord - 'a'.ord),y.to_i-1]
    end
    def to_chess_notation coordinate 
      "#{(coordinate[0]+'a'.ord).chr}#{coordinate[1]+1}"
    end
  end
end
