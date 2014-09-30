#!/usr/bin/env ruby

gem "minitest"
require 'minitest/autorun'
require_relative '../lib/chess'

class TestBoard < MiniTest::Test

  def setup
    @board=Chess::Board.new()
  end

  def test_valid_positions_knight
    @board=Chess::Board.new()
    @board.set( 'a1' )
    assert_equal( %w[ c2 b3].sort, @board.valid_positions('a1'))
  end

  def test_is_position_valid?
    @board=Chess::Board.new()
    assert_equal(false, @board.is_position_valid?( '`-1' ) )
    assert_equal(false, @board.is_position_valid?( '`1' ) )
    assert_equal(false, @board.is_position_valid?('a-1' ) )
    assert_equal(true, @board.is_position_valid?('a1' ) )
  end
end
