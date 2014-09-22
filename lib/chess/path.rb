#!/usr/bin/env ruby

module Chess

  class Path
    include Enumerable
    attr_reader :paths,:board

    def initialize 
      @paths = {}
      @board=Chess::Board.new("a1")
      post_initialize
    end

    def find_path start_position,finish_position
      path_iterate(start_position, finish_position) 
      path_to_s(start_position,finish_position) if path_exists?(start_position,finish_position)
    end

    private

    def post_initialize
      @board.each {|position|
        initialize_empty_position position
      }
    end

    def initialize_empty_position position
      @paths[position] = {} if @paths[position] == nil
      temp=@paths[position]
      temp[position] =  Neighbor.new(0,position) 
    end

    def is_path_better? position,destination,distance
      return (path_exists?(position,destination) && (lookup_path(position,destination)).distance > distance)
    end

    def lookup_path start_position, finish_position
      return @paths[start_position][finish_position] 
    end

    def path_exists? start_position, finish_position
      return false if lookup_path(start_position,finish_position) == nil
      return true
    end

    def path_iterate start_position,finish_position
      moves = [start_position,finish_position]
      while !path_exists?(start_position,finish_position) && moves.length >0
        p moves.size
        update_paths(moves.shift)
        @board.valid_positions.shuffle.each {|x|
          moves << x
        }
      end
    end

    def add_record(position,destination,distance,direction)
      if !path_exists?(position,destination) 
        @paths[position][destination] =  Neighbor.new(distance,direction) 
        puts "added record"
      elsif is_path_better?(position,destination,distance)
        @paths[position][destination] =  Neighbor.new(distance,direction) 
        puts "updated record"
      end
    end

    def update_paths position
      update_neighbors(position)
      update_self(position)
    end

    def update_neighbors position
      @board.knight(position)
      @board.valid_positions.shuffle.each {|neighbor| 
        @paths[position].each {|destination,path|
          add_record(neighbor,destination,path.distance+1,position)
        }
      }
    end

    def update_self position
      @board.knight(position)
      @board.valid_positions.shuffle.each {|neighbor| 
        @paths[neighbor].each {|destination,path|
          add_record(position,destination,path.distance+1,neighbor)
        }
      }
    end

    def path_to_s start_position, finish_position
      return "#{start_position}" if paths[start_position][finish_position].distance==0
      return "#{start_position}," + path_to_s(paths[start_position][finish_position][:direction],finish_position)
    end

  end
  Neighbor = Struct.new( :distance, :direction)
end
