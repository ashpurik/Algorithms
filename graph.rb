#!/usr/bin/env ruby

require_relative 'edge'

#open file with coordinates
file = File.open("input.txt", 'r')
lines = File.read(file).lines
input = []
#place each line of file into array
lines.each do |line|
  input.push(line) if (line.length > 0)
end

#store first line of file as 'n', number of points
num_villages = input[0].split(' ')[0]
num_lines = input[0].split(' ')[1]
layout = []

i=1
j=0
#store each edge into an array of coordinates (both directions)
while i<input.length
  village1 = input[i].split(' ')[0]
  village2 = input[i].split(' ')[1]
  color = input[i].split(' ')[2]
  type = input[i].split(' ')[3]
  layout[j] = Edge.new(village1, village2, color, type, 0)
  j+=1
  layout[j] = Edge.new(village2, village1, color, type, 0)
  j+=1
  i+=1
end 

def make_adjlists(layout)
  layout.each do |edge|
    start = edge.village1
    ending = edge.village2
    color = edge.color
    type = edge.type_transit
    layout.each do |surround| 
      if surround.village1 == ending && surround.village2 != start
        if surround.color == color || surround.type_transit == type
          edge.add_adjlist(surround)
        end
      end
    end
  end
end

def dfs(layout)
  make_adjlists(layout)
  layout.each do |edge|
    if edge.visited == 0
      dfs_visit(edge)
    end
  end
end

def dfs_visit(edge)
  edge.set_visited(1)
  edge.adj_list.each do |adj|
    if adj.visited == 0
      adj.set_parent(edge)
      dfs_visit(adj)
    end
  end
  edge.set_visited(2)
end

def storepath(layout, path)
  n=0
  p = layout[138].parent
  while p != nil
    str = "layout[138]"+".parent"*n
    p = eval(str)
    if p != nil
      str += ".village2"
      path.push(eval(str))
    else 
      break
    end
    n+=1
  end
  path.push('A')
end

def printpath(path)
  n = path.size
  while n >= 0
    puts path[n]
    n-=1
  end
end

path = []
dfs(layout)
storepath(layout, path)
puts path.size
printpath(path)
