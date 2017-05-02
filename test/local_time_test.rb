require_relative './fake_clock'
require_relative '../lib/rhodatime'
require 'minitest/autorun'

class TestDateTime < Minitest::Test

  def test_of_default_params
    t = RhodaTime::LocalTime.of(3, 4)
    assert_equal(3, t.hour)
    assert_equal(4, t.minute)
    assert_equal(0, t.second)
    assert_equal(0, t.millis)
  end

  def test_of
    t = RhodaTime::LocalTime.of(3, 4, 5, 6)
    assert_equal(3, t.hour)
    assert_equal(4, t.minute)
    assert_equal(5, t.second)
    assert_equal(6, t.millis)
  end

  def test_of_hour_too_high
    assert_raises RhodaTime::DateTimeException do
      RhodaTime::LocalTime.of(24, 4, 5, 6)
    end
  end

  def test_of_hour_too_low
    assert_raises RhodaTime::DateTimeException do
      RhodaTime::LocalTime.of(-1, 4, 5, 6)
    end
  end

  def test_of_minute_too_low
    assert_raises RhodaTime::DateTimeException do
      RhodaTime::LocalTime.of(1, -1, 5, 6)
    end
  end

  def test_of_minute_too_high
    assert_raises RhodaTime::DateTimeException do
      RhodaTime::LocalTime.of(1, 60, 5, 6)
    end
  end

  def test_now
    t = RhodaTime::LocalTime.now
    assert(!t.nil?)
  end

  def test_now_with_clock
    t = RhodaTime::LocalTime.now(clock=FakeClock.new(1493737591312))
    assert_equal(15, t.hour)
    assert_equal(6, t.minute)
    assert_equal(31, t.second)
    assert_equal(312, t.millis)
  end

  def test_after_same_hour
    t1 = RhodaTime::LocalTime.of(12, 30)
    t2 = RhodaTime::LocalTime.of(12, 15)
    assert(t1.after?(t2))
    assert(!t2.after?(t1))
  end

  def test_after_same
    t1 = RhodaTime::LocalTime.of(12, 30)
    t2 = RhodaTime::LocalTime.of(12, 30)
    assert(!t1.after?(t2))
    assert(!t2.after?(t1))
  end

  def test_after_different_hour
    t1 = RhodaTime::LocalTime.of(13, 15)
    t2 = RhodaTime::LocalTime.of(12, 30)
    assert(t1.after?(t2))
    assert(!t2.after?(t1))
  end

  def test_after_lesser_hour
    t1 = RhodaTime::LocalTime.of(11, 30)
    t2 = RhodaTime::LocalTime.of(12, 15)
    assert(!t1.after?(t2))
    assert(t2.after?(t1))
  end

  def test_to_s
    assert_equal("09:14", RhodaTime::LocalTime.of(9, 14).to_s)
    assert_equal("09:06:14", RhodaTime::LocalTime.of(9, 6, 14).to_s)
    assert_equal("09:06:14.001", RhodaTime::LocalTime.of(9, 6, 14, 1).to_s)
  end
end