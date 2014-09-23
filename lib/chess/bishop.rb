module Chess
  class Bishop < Chess::Piece
    def post_initialize 
      moves=(-8..8).map {|number| [number,number]}
       @possible_moves = moves
    end
  end
end
