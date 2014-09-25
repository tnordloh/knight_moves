module Chess

  class Path
    include Enumerable

    def initialize piece = Chess::Knight.new()
      @paths = {}
      @board=Chess::Board.new(8)
      @board.each {|position| add_zero_distance_path position }
      @last_change = Hash.new(0)
      @board.replace_piece piece
    end

    def find_path start_position,finish_position
      path_iterate(start_position, finish_position) 
      to_s(start_position,finish_position)
    end

    private

    def add_zero_distance_path position
      @paths[position] ||= {} 
      temp=@paths[position]
      temp[position] =  Neighbor.new(0,position) 
    end

    def is_new_path_shorter_than_current? position,destination,distance
      return (path_exists?(position,destination) && (lookup_path(position,destination)).distance > distance)
    end

    def lookup_path start_position, finish_position
      return @paths[start_position][finish_position] 
    end

    def path_exists? start_position, finish_position
      !!lookup_path(start_position,finish_position)
    end

    def path_iterate start_position,finish_position
      moves = [start_position,finish_position]
      iterations=1
      while !path_exists?(start_position,finish_position) && moves.length >0
        current_position= moves.shift
        build_on_known_paths(current_position)
        @board.valid_positions(current_position).shuffle.each {|x|
          moves << x unless moves.include?(x) || @last_change[x] > 64
        }
      end
    end

    def record_new_path(position,destination,distance,direction)
      if !path_exists?(position,destination) || is_new_path_shorter_than_current?(position,destination,distance)
        @last_change[position] =0
        @paths[position][destination] =  Neighbor.new(distance,direction) 
      else
        @last_change[position] +=1
      end
    end

    def build_on_known_paths position
      add_neighbor_paths_to_current_position(position)
      add_current_position_paths_to_neighbors(position)
    end

    def add_neighbor_paths_to_current_position position
      @board.valid_positions(position).each {|neighbor| 
        @paths[position].each {|destination,path|
          record_new_path(neighbor,destination,path.distance+1,position)
        }
      }
    end

    def add_current_position_paths_to_neighbors position
      @board.valid_positions(position).each {|neighbor| 
        @paths[neighbor].each {|destination,path|
          record_new_path(position,destination,path.distance+1,neighbor)
        }
      }
    end

    def to_s start_position, finish_position
      return "no path found" unless path_exists?(start_position,finish_position)
      return "#{start_position}" if @paths[start_position][finish_position].distance==0
      return "#{start_position}," + to_s(@paths[start_position][finish_position][:direction],finish_position)
    end

  end
  Neighbor = Struct.new( :distance, :direction)
end
