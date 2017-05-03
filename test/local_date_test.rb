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

  def test_at_start_of_day
    d = RhodaTime::LocalDate.now(clock=FakeClock.new(1514757599000))
    dt = d.at_start_of_day
    assert_equal(2017, dt.year)
    assert_equal(12, dt.month)
    assert_equal(31, dt.day)
    assert_equal(0, dt.hour)
    assert_equal(0, dt.minute)
    assert_equal(0, dt.second)
    assert_equal(0, dt.millis)
  end

  def test_with_local_time
    d = RhodaTime::LocalDate.of(2017, 3, 14)
    dt = d.with_time(RhodaTime::LocalTime.of(2, 3, 4, 5))
    assert_equal(2017, dt.year)
    assert_equal(3, dt.month)
    assert_equal(14, dt.day)
    assert_equal(2, dt.hour)
    assert_equal(3, dt.minute)
    assert_equal(4, dt.second)
    assert_equal(5, dt.millis)
  end
end