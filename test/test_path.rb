#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/chess'

class TestBoard < MiniTest::Test

  def setup
    @path=Chess::Path.new()
  end

  def test_find_path
    assert_equal("a1,c2",@path.find_path('a1','c2'))
    @path=Chess::Path.new()
    paths_a1_to_a2= ["a1,c2,b4,a2","a1,b3,c1,a2"]
    assert_includes(paths_a1_to_a2,@path.find_path('a1','a2'))
  end

end
