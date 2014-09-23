#!/usr/bin/env ruby
require_relative "../lib/chess.rb"
p=Chess::Path.new()
if ARGV.size != 2
  puts "expecting 2 arguments"
  exit 1
end
puts p.find_path(ARGV[0],ARGV[1])
