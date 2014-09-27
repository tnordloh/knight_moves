#!/usr/bin/env ruby
require_relative "../lib/chess.rb"
p=Chess::PathDirector.new()
if ARGV.size != 2
  abort "error: this program finds the path between two positions on a chess board
  it takes it's arguments in chess notation. 
  example: #{__FILE__} a1 c2"
end
puts p.find_path(ARGV[0],ARGV[1])
