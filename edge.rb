class Edge

  attr_accessor :village1
  attr_accessor :village2
  attr_accessor :color
  attr_accessor :type_transit
  attr_accessor :visited
  attr_accessor :parent
  attr_accessor :adj_list

  def initialize(village1, village2, color, type_transit, visited)
    @village1 = village1
    @village2 = village2
    @color = color
    @type_transit = type_transit   
    #0 means not visited
    #1 means currently visiting
    #2 means visited
    @visited = visited 
    @parent = nil
    @adj_list = []
  end

  def add_adjlist(vertex)
    @adj_list.push(vertex)
  end

  def print_adjlist
    @adj_list.each do |edge|
      puts "Village1: #{edge.village1}, Village2: #{edge.village2}, Color: #{edge.color}, Type: #{edge.type_transit}"
    end
  end

  def set_visited(state)
    @visited = state
  end

  def set_parent(edge)
    @parent = edge
  end

end