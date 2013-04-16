#!/usr/bin/env ruby
# Author: Anastasia Shpurik
# Professor: Dinesh Mehta
# Course: CSCI406
# Project3: Graph Modeling 

require_relative 'edge'

#open file with coordinates
file = File.open("input.txt", 'r')
lines = File.read(file).lines
input = []
#place each line of file into array
lines.each do |line|
  input.push(line) if (line.length > 0)
end

#store first line of file as number of villages
num_villages = input[0].split(' ')[0]
#store second line of file as number of routes
num_lines = input[0].split(' ')[1]
layout = []

i=1
j=0
#store each edge into an array of edges (both directions)
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

#create adjacency lists for each edge
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

#dfs algorithm
def dfs(layout)
  make_adjlists(layout)
  #for each vertex, if it hasn't been visited, visit it
  layout.each do |edge|
    if edge.visited == 0
      dfs_visit(edge)
    end
  end
end

def dfs_visit(edge)
  #mark the vertex you are currently on
  edge.set_visited(1)
  #for each adjacent vertex, if it hasn't been visited, visit it
  edge.adj_list.each do |adj|
    if adj.visited == 0
      #assign the parent vertex of each vertex
      adj.set_parent(edge)
      dfs_visit(adj)
    end
  end
  #mark the edge as visited
  edge.set_visited(2)
end

#get all of the parent vertices and construct a path
def storepath(layout, path)
  n=0
  #the path starts at the end; 'j'
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

#print out the path, from beginning to end
def printpath(path)
  puts "Path: From Startsburg (A) to Endenville (j)"
  n = path.size
  while n >= 0
    print("#{path[n]} ")
    n-=1
  end
  puts "\n"
  puts "Path length: #{path.size-2}"
end

#initialize empty path, do dfs on it
path = []
dfs(layout)
storepath(layout, path)
printpath(path)
