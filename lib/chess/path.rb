module Chess

  class DoomedClass
    include Enumerable

    def initialize piece = KNIGHT_MOVES
      @map = {}
      @board=Chess::Board.new(8)
      @last_change = Hash.new(0)
      @board.replace_piece piece
      initialize_path_builders
    end

    def find_path start_position,finish_position
      path_iterate(start_position, finish_position) 
      to_s(start_position,finish_position)
    end

    private
    def initialize_path_builders
      @board.each {|position| @map[position] = Chess::PathBuilder.new(position) }
      @map.each {|key,position| 
        @board.valid_positions(key).each {|x|
          position.add_immediate_neighbor(x)
        }
      }
    end

    def any_dirty_paths?
      @map.values.any? {|value| value.dirty }
    end

    def path_exists? start_position, finish_position
      !!@map[start_position].path(finish_position)
    end

    def path_iterate start_position,finish_position
      moves = [start_position,finish_position]
      iterations=1
      while !path_exists?(start_position,finish_position) && any_dirty_paths?
        current_position= moves.shift
        build_on_known_paths(current_position)
        @map[current_position].immediate_neighbors.shuffle.each {|x|
          moves << x unless moves.include?(x) 
        }
      end
    end

    def build_on_known_paths position
      @map[position].immediate_neighbors.each {|neighbor| 
        @map[position].sync_neighbor_paths(neighbor,@map[neighbor].paths)
        @map[neighbor].sync_neighbor_paths(position,@map[position].paths)
      }
    end

    def to_s start_position, finish_position
      return "no path found" unless path_exists?(start_position,finish_position)
      return "#{start_position}" if @map[start_position].path(finish_position).distance==0
      return "#{start_position}," + to_s(@map[start_position].path(finish_position).direction,finish_position)
    end

  end
  Neighbor = Struct.new( :distance, :direction)
end
