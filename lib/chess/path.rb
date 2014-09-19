#!/usr/bin/env ruby

module Chess

  class Path
    def initialize 
      @paths = {}
    end
    def find_path start_position,finish_position
      @start_position, @finish_position = start_position,finish_position
      return path_iterate @start_position, @finish_position
    end
    def path_iterate start_position,finish_position
      path =  lookup_path @start_position, @finish_position
      if path != nil 
        return path_to_s @start_position, @finish_position
      else
        plot_neighbors(start_position).each {|new_start_position| 
          path =  lookup_path @start_position, @finish_position
          return path_to_s(@start_position,@finish_position) if path != nil 
          puts "*" *20 +"back in iterate"
          path_iterate(new_start_position,@finish_position)
        }
      end
    end
    def paths
      return @paths
    end
    def lookup_path start_position, finish_position
      start_of_path=@paths[start_position]
      return start_of_path[finish_position] unless start_of_path == nil
      return nil
    end
    def path_exists? start_position, finish_position
      return false if lookup_path(start_position,finish_position) == nil
      return true
    end
    def plot_neighbors position
      add_path(position,position,0,position)
      board = Chess::Board.new(position)
      board.valid_positions.each {|v_position|
        add_path(position,v_position,1,v_position)
      }
      return board.valid_positions.shuffle
    end
    def add_record(position,destination,distance,direction)
      puts "in add_record"
      if path_exists?(position,destination) 
        if (lookup_path(position,destination)).distance > distance
          temp=@paths[position]
          puts "entry exists, but replaciing with better option"
          temp[destination] =  Neighbor.new(destination,distance,direction) 
          puts "added path #{temp[destination]}"
          trigger_update=true
          return true
        else
          puts "path exists, but better path already found.  Nothing added. trigger should be false, and is [#{trigger_update}]"
          return false
        end
      else
        @paths[position] = {} if @paths[position] == nil
        temp=@paths[position]
        temp[destination] =  Neighbor.new(destination,distance,direction) 
        puts "added path #{temp[destination]}"
        return true
      end
      return trigger_update
    end
    def add_path position, destination, distance, direction
      trigger_update=add_record(position,destination,distance,direction)
      p trigger_update
      if(trigger_update == true) 
        puts "in trigger_update"
        p @paths[position]
        updatelist=@paths.select {|k,v| path_exists?(k,position) }
        update_neighbors(position,lookup_path(position,destination),updatelist)
      end
    end
    def update_neighbors position,new_path,updatelist
      updatelist.keys.each {|k|
        addme=lookup_path(k,position)
        puts "key:#{k}"
        add_path(k,new_path.name,new_path.distance+addme.distance,addme.direction)
      }
    end
    private
    def path_to_s start_position, finish_position
      value = nil
      value = @paths[start_position][finish_position] if lookup_path(start_position,finish_position) != nil 
      return "#{start_position}" if value == nil
      return "#{start_position}," + path_to_s(value[:direction],finish_position)
    end
  end
  Neighbor = Struct.new(:name, :distance, :direction)
end
