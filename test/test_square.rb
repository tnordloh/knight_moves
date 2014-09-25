#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/chess'

class TestSquare < MiniTest::Test

  def setup
    @square=Chess::Square.new()
  end

  def test_to_coordinate
    assert_equal( [0,0] , @square.to_coordinate("a1"))
    assert_equal( [0,-1] , @square.to_coordinate("a0"))
    assert_equal( [1,-2] , @square.to_coordinate("b-1"))
  end

  def test_to_chess_notation?
    assert_equal( "a1", @square.to_chess_notation([0,0]))
    assert_equal( "a0", @square.to_chess_notation([0,-1]))
  end

end
