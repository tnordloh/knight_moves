#!/usr/bin/env ruby

module Chess

  class Path
    attr_reader :paths

    def initialize 
      @paths = {}
      @board=Chess::Board.new("a1")
      post_initialize
    end

    def post_initialize
      ('a'..'h').each { |row|
        (1..8).each { |column|
          position="#{row}#{column}"
          @paths[position] = {} if @paths[position] == nil
          temp=@paths[position]
          temp[position] =  Neighbor.new(0,position) 
        }
      }
    end

    def is_path_better? position,destination,distance
      return (path_exists?(position,destination) && (lookup_path(position,destination)).distance > distance)
    end

    def lookup_path start_position, finish_position
      return start_of_path=@paths[start_position][finish_position] 
    end

    def path_exists? start_position, finish_position
      return false if lookup_path(start_position,finish_position) == nil
      return true
    end

    def find_path start_position,finish_position
      @start_position, @finish_position = start_position,finish_position
      path_iterate @start_position, @finish_position
      path_to_s(@start_position,@finish_position)
    end

    def path_iterate start_position,finish_position
      return true if path_exists? @start_position, @finish_position
      plot_neighbors(start_position).each {|new_start_position| 
          return path_iterate(new_start_position,@finish_position) 
      }
    end

    def plot_neighbors position
      @board.knight(position)
      @board.valid_positions.each {|v_position|
        add_path(position,v_position,1,v_position)
      }
      @board.knight(position)
      return @board.valid_positions.shuffle
    end

    def add_record(position,destination,distance,direction)
      if !path_exists?(position,destination) || is_path_better?(position,destination,distance)
        @paths[position][destination] =  Neighbor.new(distance,direction) 
        return true
      end
      return false
    end

    def add_path position, destination, distance, direction
      if(add_record(position,destination,distance,direction))
        updatelist=@paths.keys.select {|k| path_exists?(k,position) && !path_exists?(k,destination)}
        update_neighbors(position,destination,distance,updatelist) if (updatelist != nil && updatelist.size >0)
      end
    end

    def update_neighbors position,destination,distance,updatelist
      updatelist.each {|k| 
        addme=lookup_path(k,position)
        local_distance,direction=addme.distance,addme.direction
        add_path(k,destination,local_distance+distance,direction)
      }
    end

    private

    def path_to_s start_position, finish_position
      value = nil
      value = paths[start_position][finish_position] if lookup_path(start_position,finish_position) != nil 
      p value
      return "#{start_position}" if value.distance==0
      return "#{start_position}," + path_to_s(value[:direction],finish_position)
    end

  end
  Neighbor = Struct.new( :distance, :direction)
end
