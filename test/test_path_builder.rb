#!/usr/bin/env ruby

gem "minitest"
require 'minitest/autorun'
require_relative '../lib/chess.rb'

class TestPathBuilder < MiniTest::Test
  def setup
    @pb=Chess::PathBuilder.new('a1')
  end
  def test_add_path
    @pb.add_path("c2",1,"c2") 
    assert_equal( 1,    @pb.paths['c2'].distance)
    assert_equal(true, @pb.dirty)
    @pb.add_path("a1",1,"a1") 
    assert_equal( 0,    @pb.paths['a1'].distance)
    assert_equal(false, @pb.dirty)
    10.times  {@pb.add_path("a1",1,"a1") }
    assert_equal(false, @pb.dirty)
    @pb.add_path("b3",1,"b3") 
    assert_equal(true, @pb.dirty)
  end
  def test_path
    assert_equal("a1", @pb.path('a1').direction)
    assert_equal(nil, @pb.path('c2'))
  end
  def untest_counter
    @pb.add_path("c2",1,"c2")
    assert_equal(0, @pb.last_change)
  end
end
