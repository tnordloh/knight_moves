module Chess
  class Knight < Chess::Piece
    def post_initialize 
       @possible_moves = [[2, 1],[2, -1], [1, 2],[1, -2],
                    [-1,2],[-1,-2],
                    [-2,1],[-2,-1] ]
    end
  end
end
