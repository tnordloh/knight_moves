#!/usr/bin/env ruby
require_relative "../lib/chess.rb"
if ARGV.size < 2
  abort "error: this program finds the path between two positions on a chess board
  it takes it's arguments in chess notation. 
  arg1=start position
  arg2=finish position
  arg3 to argn are optional, and are used to exclude specific squares from the allowed positions
  example: #{__FILE__} a1 c2 [b4]"
end
p=Chess::PathDirector.new(KNIGHT_MOVES,(ARGV[2..-1] || []))
puts p.find_path(ARGV[0],ARGV[1])
