module Chess
  class Bishop < Chess::Piece
    def initialize position
      super
      moves=(1..8).map {|number| ["up_right", [number,number]]}
      moves+=(1..8).map {|number| ["up_left", [number,number]]}
      moves+=(1..8).map {|number| ["down_right", [number,number]]}
      moves+=(1..8).map {|number| ["down_left", [number,number]]}
      moves+= [["up",[0]]]
      @possible_moves = moves
    end
  end
end
