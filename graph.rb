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
#store each edge into an array of coordinates
while i<input.length
  village1 = input[i].split(' ')[0]
  village2 = input[i].split(' ')[1]
  color = input[i].split(' ')[2]
  type = input[i].split(' ')[3]
  layout[i-1] = Edge.new(village1, village2, color, type, 0)
  i+=1
end  

# layout.each do |edge|
#   puts "Village1: #{edge.village1}, Village2: #{edge.village2}, Color: #{edge.color}, Type: #{edge.type_transit}, Visited: #{edge.visited}"
# ends

def make_adjlists
  
end

def dfs
  layout.each do |vertex|
    if vertex.visited == 0
      dfs_visit(vertex)
    end
  end
end

def dfs_visit(vertex)
  vertex.visited = 1
end