require_relative './fake_clock'
require_relative '../lib/rhodatime'
require 'minitest/autorun'

class TestLocalDate < Minitest::Test

  def test_local_of
    d = RhodaTime::LocalDate.of(2017, 12, 1)
    assert_equal(2017, d.year)
    assert_equal(12, d.month)
    assert_equal(1, d.day)
  end

  def test_local_now
    d = RhodaTime::LocalDate.now(clock=FakeClock.new(1483228800000))
    assert_equal(2017, d.year)
    assert_equal(1, d.month)
    assert_equal(1, d.day)
  end

  def test_local_now2
    d = RhodaTime::LocalDate.now(clock=FakeClock.new(1514764800000))
    assert_equal(2018, d.year)
    assert_equal(1, d.month)
    assert_equal(1, d.day)
  end

  def test_local_now3
    d = RhodaTime::LocalDate.now(clock=FakeClock.new(1514757599000))
    assert_equal(2017, d.year)
    assert_equal(12, d.month)
    assert_equal(31, d.day)
  end
end