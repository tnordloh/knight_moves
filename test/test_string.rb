#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/board'

class TestString < MiniTest::Test

  def test_offset
    assert_equal( "c", "b".offset(1))
    assert_equal( "a", "b".offset(-1))
    assert_equal( "a", "d".offset(-3))
  end
end
