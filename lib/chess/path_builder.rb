module Chess
  class PathBuilder
    include Enumerable
    attr_reader :paths, :last_change, :dirty, :immediate_neighbors

    def initialize home
      @paths = {}
      @paths[home] = Neighbor.new(0,home)
      @dirty = true
      @immediate_neighbors = []
    end

    def add_immediate_neighbor destination
      add_path(destination,1,destination)
      @immediate_neighbors << destination
    end

    def sync_neighbor_paths neighbor,paths
      paths.each {|key,path| add_path(key,path.distance+1,neighbor)}
    end

    def path path
      @paths[path]
    end

    def is_recorded_path_shorter? destination, distance
      (exists?(destination) && @paths[destination][:distance] <= distance )
    end

    def exists? destination
      !!@paths[destination]
    end

    #private
    def add_path destination, distance, direction
      if(is_recorded_path_shorter?(destination,distance)) 
        @dirty=false
        return
      end 
      @dirty=true 
      @paths[destination] = Neighbor.new(distance,direction) 
    end
  end
end
