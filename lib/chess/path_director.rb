module Chess

  class PathDirector
    include Enumerable

    def initialize piece = KNIGHT_MOVES
      @pathlist = {}
      @board=Chess::Board.new(8)
      @board.replace_piece piece
      initialize_path_builders
    end

    def find_path start_position,finish_position
      moves = [start_position,finish_position]
      while !path_exists?(start_position,finish_position) && any_dirty_paths?
        discover_new_neighbors(moves.shift).each {|x| 
          moves << x unless moves.include?(x) }
      end
      to_s(start_position,finish_position)
    end

    private
    def initialize_path_builders
      @board.each {|position| @pathlist[position] = Chess::PathBuilder.new(position) }
      initialize_immediate_neighbors
    end

    def initialize_immediate_neighbors
      @pathlist.values.each {|position| 
        @board.valid_positions(position.home).each {|neighbor| 
          position.add_immediate_neighbor(@pathlist[neighbor]) 
        }
      }
    end

    def any_dirty_paths?
      @pathlist.values.any? {|value| value.dirty }
    end

    def path_exists? start_position, finish_position
      !!@pathlist[start_position].path(finish_position)
    end

    def discover_new_neighbors position
      @pathlist[position].sync_neighbor_paths
      return @pathlist[position].immediate_neighbors
    end

    def to_s start_position, finish_position
      return "no path found" unless path_exists?(start_position,finish_position)
      return "#{start_position}" if @pathlist[start_position].path(finish_position).distance==0
      return "#{start_position}," + to_s(@pathlist[start_position].path(finish_position).direction,finish_position)
    end

  end
  Neighbor = Struct.new( :distance, :direction)
end
