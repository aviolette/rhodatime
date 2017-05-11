require_relative './fake_clock'
require_relative '../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  class TestLocalTime < Minitest::Test

    def test_of_default_params
      t = LocalTime.of(3, 4)
      assert_equal(3, t.hour)
      assert_equal(4, t.minute)
      assert_equal(0, t.second)
      assert_equal(0, t.millis)
    end

    def test_of
      t = LocalTime.of(3, 4, 5, 6)
      assert_equal(3, t.hour)
      assert_equal(4, t.minute)
      assert_equal(5, t.second)
      assert_equal(6, t.millis)
    end

    def test_of_hour_too_high
      assert_raises DateTimeException do
        LocalTime.of(24, 4, 5, 6)
      end
    end

    def test_of_hour_too_low
      assert_raises DateTimeException do
        LocalTime.of(-1, 4, 5, 6)
      end
    end

    def test_of_minute_too_low
      assert_raises DateTimeException do
        LocalTime.of(1, -1, 5, 6)
      end
    end

    def test_of_minute_too_high
      assert_raises DateTimeException do
        LocalTime.of(1, 60, 5, 6)
      end
    end

    ## NOW

    def test_now
      t = LocalTime.now
      assert(!t.nil?)
    end

    def test_now_with_clock
      t = LocalTime.now(clock=FakeClock.new(1493737591312))
      assert_equal(15, t.hour)
      assert_equal(6, t.minute)
      assert_equal(31, t.second)
      assert_equal(312, t.millis)
    end


    def test_local_now_other_zone
      d = LocalTime.now(clock=FakeClock.new(1483228800000, -18000))
      assert_equal(19, d.hour)
      assert_equal(0, d.minute)
      assert_equal(0, d.second)
    end

    ## AFTER?

    def test_after_same_hour
      t1 = LocalTime.of(12, 30)
      t2 = LocalTime.of(12, 15)
      assert(t1.after?(t2))
      assert(!t2.after?(t1))
    end

    def test_after_same
      t1 = LocalTime.of(12, 30)
      t2 = LocalTime.of(12, 30)
      assert(!t1.after?(t2))
      assert(!t2.after?(t1))
    end

    def test_after_different_hour
      t1 = LocalTime.of(13, 15)
      t2 = LocalTime.of(12, 30)
      assert(t1.after?(t2))
      assert(!t2.after?(t1))
    end

    def test_after_lesser_hour
      t1 = LocalTime.of(11, 30)
      t2 = LocalTime.of(12, 15)
      assert(!t1.after?(t2))
      assert(t2.after?(t1))
    end

    def test_after_different_second
      t1 = LocalTime.of(11, 30, 5)
      t2 = LocalTime.of(11, 30, 6)
      assert(!t1.after?(t2))
      assert(t2.after?(t1))
    end

    def test_after_different_second2
      t1 = LocalTime.of(11, 30, 5, 1)
      t2 = LocalTime.of(11, 30, 5, 0)
      assert(t1.after?(t2))
      assert(!t2.after?(t1))
    end

    ## BEFORE?

    def test_before_same
      t1 = LocalTime.of(11, 30)
      t2 = LocalTime.of(11, 30)
      assert(!t1.before?(t2))
      assert(!t2.before?(t1))
    end

    def test_before1
      t1 = LocalTime.of(9, 45)
      t2 = LocalTime.of(11, 30)
      assert(t1.before?(t2))
      assert(!t2.before?(t1))
    end

    ## TO_S

    def test_to_s
      assert_equal("09:14", LocalTime.of(9, 14).to_s)
      assert_equal("09:06:14", LocalTime.of(9, 6, 14).to_s)
      assert_equal("09:06:14.001", LocalTime.of(9, 6, 14, 1).to_s)
    end

    ## AT_DATE

    def test_at_date
      date = LocalTime.of(9,11,12,13).at_date(LocalDate.of(2014, 2, 3))
      assert_equal(2014, date.year)
      assert_equal(2, date.month)
      assert_equal(3, date.day)
      assert_equal(9, date.hour)
      assert_equal(11, date.minute)
      assert_equal(12, date.second)
      assert_equal(13, date.millis)
    end

    ## WITH_HOUR

    def test_with_hour
      time = LocalTime.of(9,11,12,13).with_hour(10)
      assert_equal(10, time.hour)
      assert_equal(11, time.minute)
      assert_equal(12, time.second)
      assert_equal(13, time.millis)
    end

    def test_with_hour_too_high
      assert_raises DateTimeException do
        LocalTime.of(9,11,12,13).with_hour(24)
      end
    end

    def test_with_hour_too_low
      assert_raises DateTimeException do
        LocalTime.of(9,11,12,13).with_hour(-1)
      end
    end

    ## WITH_MINUTE

    def test_with_minute
      time = LocalTime.of(9,11,12,13).with_minute(10)
      assert_equal(9, time.hour)
      assert_equal(10, time.minute)
      assert_equal(12, time.second)
      assert_equal(13, time.millis)
    end

    def test_with_minute_too_high
      assert_raises DateTimeException do
        LocalTime.of(9,11,12,13).with_minute(60)
      end
    end

    def test_with_minute_too_low
      assert_raises DateTimeException do
        LocalTime.of(9,11,12,13).with_minute(-1)
      end
    end

    ## WITH_SECOND

    def test_with_second
      time = LocalTime.of(9,11,12,13).with_second(10)
      assert_equal(9, time.hour)
      assert_equal(11, time.minute)
      assert_equal(10, time.second)
      assert_equal(13, time.millis)
    end

    def test_with_second_too_high
      assert_raises DateTimeException do
        LocalTime.of(9,11,12,13).with_second(60)
      end
    end

    def test_with_second_too_low
      assert_raises DateTimeException do
        LocalTime.of(9,11,12,13).with_second(-1)
      end
    end

    ## WITH_MILLIS

    def test_with_millis
      time = LocalTime.of(9,11,12,13).with_millis(999)
      assert_equal(9, time.hour)
      assert_equal(11, time.minute)
      assert_equal(12, time.second)
      assert_equal(999, time.millis)
    end

    def test_with_millis_too_high
      assert_raises DateTimeException do
        LocalTime.of(9,11,12,13).with_millis(1000)
      end
    end

    def test_with_millis_too_low
      assert_raises DateTimeException do
        LocalTime.of(9,11,12,13).with_millis(-1)
      end
    end
  end
end
