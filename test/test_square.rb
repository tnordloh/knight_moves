#!/usr/bin/env ruby

gem "minitest"
require 'minitest/autorun'
require_relative '../lib/chess'

class TestSquare < MiniTest::Test

  def setup
    @square=Chess::Square.new("a1")
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

  def test_up
    assert_equal("a2", @square.move({:up => 1}))
    assert_equal("a4", @square.move({:up => 3}))
  end

  def test_down
    assert_equal("a0", @square.move({:down => 1}))
    assert_equal("a-2", @square.move(:down => 3))
  end

  def test_left
    assert_equal("`1", @square.move({:left => 1}))
    assert_equal("_1", @square.move({:left => 2}))
  end

  def test_right
    assert_equal("b1", @square.move({:right => 1}))
    assert_equal("c1", @square.move({:right => 2}))
  end

  def test_up_right
    assert_equal("b2", @square.move({:right => 1, :up => 1}))
    assert_equal("c3", @square.move({:right => 2, :up => 2}))
  end

  def test_moves
    @square.add_piece(BISHOP_MOVES)
    values = ["a1", "b0", "c-1", "d-2", "e-3", "f-4", "g-5", "h-6", "i-7", "`0", "_-1", "^-2", "]-3", "\\-4", "[-5", "Z-6", "Y-7", "b2", "c3", "d4", "e5", "f6", "g7", "h8", "i9", "`2", "_3", "^4", "]5", "\\6", "[7", "Z8", "Y9"]
    values.sort!
    assert_equal(values, @square.moves.sort!)
  end

end
