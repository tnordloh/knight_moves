#!/usr/bin/env ruby
require_relative "../lib/chess.rb"
p=Chess::Path.new()
puts p.find_path(ARGV[0],ARGV[1])
