#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/board'

class TestBoard < MiniTest::Test

  def setup
    @board=Board::Board.new()
  end
  def test_knights
    @board.knight( {:row => 'a', :column =>1 })
    arr = [2, 1], [1, 2]
    assert_equal( arr, @board.valid_moves)
  end
end
