#!/usr/bin/env ruby

gem "minitest"
require 'minitest/autorun'
require_relative '../lib/chess/path_director'
require_relative '../lib/chess/path_builder'
require_relative '../lib/chess/board'
require_relative '../lib/chess/square'
require_relative '../lib/chess/constants'

class TestPathDirector < MiniTest::Test

  def setup
    @path=Chess::PathDirector.new()
  end

  def test_find_path_knight
    assert_equal("a1,c2",@path.find_path('a1','c2'))
    paths_a1_to_a2= ["a1,c2,b4,a2","a1,b3,c1,a2"]
    assert_includes(paths_a1_to_a2,@path.find_path('a1','a2'))
  end

end
