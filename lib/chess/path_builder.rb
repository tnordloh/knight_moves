module Chess
  class PathBuilder
    include Enumerable
    attr_reader :paths, :last_change, :dirty, :home

    def initialize home
      @paths = {}
      @home = home
      @paths[home] = Neighbor.new(0,home)
      @dirty = true
      @immediate_neighbors = []
    end

    def add_immediate_neighbor path
      add_path(path.home,1,path.home)
      @immediate_neighbors << path
    end

    def immediate_neighbors
      @immediate_neighbors.map {|neighbor| neighbor.home}
    end

    def sync_neighbor_paths 
      @immediate_neighbors.each {|neighbor| 
        paths.each {|destination,path| neighbor.add_path(destination,path.distance+1,home) }
      }
    end

    def path path
      @paths[path]
    end

    def add_path destination, distance, direction
      if(is_recorded_path_shorter?(destination,distance)) 
        @dirty=false
        return
      end 
      @dirty=true 
      @paths[destination] = Neighbor.new(distance,direction) 
    end

    private
    def exists? destination
      !!@paths[destination]
    end

    def is_recorded_path_shorter? destination, distance
      (exists?(destination) && @paths[destination].distance <= distance )
    end

  end
end
