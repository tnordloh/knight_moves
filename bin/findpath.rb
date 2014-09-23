#!/usr/bin/env ruby
require_relative "../lib/chess.rb"
p=Chess::Path.new()
if ARGV.size != 2
  abort "expecting 2 arguments"
end
puts p.find_path(ARGV[0],ARGV[1])
