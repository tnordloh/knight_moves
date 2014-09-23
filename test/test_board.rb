#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/chess'

class TestBoard < MiniTest::Test

  def setup
    @board=Chess::Board.new()
  end

  def test_valid_moves
    @board=Chess::Board.new()
    @board.set( 'a1' )
    arr = [2, 1], [1, 2]
    assert_equal( arr, @board.valid_moves)
  end

  def test_valid_positions_knight
    @board=Chess::Board.new()
    @board.set( 'a1' )
    assert_equal( %w[ c2 b3], @board.valid_positions)
  end

  def test_valid_positions_bishop
    @board=Chess::Board.new()
    @board.replace_piece("bishop","a1")
    @board.set( 'b2' )
    assert_equal( %w[ a1 b2 c3 d4 e5 f6 g7 h8 a3 c1], @board.valid_positions)
  end
end
