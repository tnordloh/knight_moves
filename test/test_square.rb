#!/usr/bin/env ruby

gem "minitest"
require 'minitest/autorun'
require_relative '../lib/chess'

class TestSquare < MiniTest::Test

  def setup
    @square=Chess::Square.new("a1")
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

end
