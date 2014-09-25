module Chess
  class Knight < Chess::Piece
    def initialize 
      @possible_moves = [
        ["up_left", [2, 1]],
        ["up_right", [2, 1]],
        ["up_left", [1, 2]],
        ["up_right", [1,2]],
        ["down_left", [2, 1]],
        ["down_right", [2, 1]],
        ["down_left", [1, 2]],
        ["down_right", [1,2]]
      ]
    end
  end
end
