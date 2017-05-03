require_relative './fake_clock'
require_relative '../lib/rhodatime'
require 'minitest/autorun'

class TestLocalDateTime < Minitest::Test

  def test_local_of
    d = RhodaTime::LocalDateTime.of(2017, 12, 1, 13, 14, 15, 16)
    assert_equal(2017, d.year)
    assert_equal(12, d.month)
    assert_equal(1, d.day)
    assert_equal(13, d.hour)
    assert_equal(14, d.minute)
    assert_equal(15, d.second)
    assert_equal(16, d.millis)
  end

  def test_local_now
    d = RhodaTime::LocalDateTime.now(clock=FakeClock.new(1483228800000))
    assert_equal(2017, d.year)
    assert_equal(1, d.month)
    assert_equal(1, d.day)
    assert_equal(0, d.hour)
    assert_equal(0, d.minute)
    assert_equal(0, d.second)
  end
end