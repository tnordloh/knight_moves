#!/usr/bin/env ruby
require_relative "../lib/chess.rb"
unless (2..3).cover?(ARGV.size) 
  abort "error: this program finds the path between two positions on a chess board
  it takes it's arguments in chess notation. 
  example: #{__FILE__} a1 c2"
end
p=Chess::PathDirector.new(KNIGHT_MOVES,[ARGV[2]]|| [])
puts p.find_path(ARGV[0],ARGV[1])
