require_relative './fake_clock'
require_relative '../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  class TestLocalDateTime < Minitest::Test

    def setup
      @date_time = LocalDateTime.of(2017, 12, 1, 13, 14, 15, 16)
    end

    def test_local_of
      assert_equal(2017, @date_time.year)
      assert_equal(12, @date_time.month)
      assert_equal(1, @date_time.day)
      assert_equal(13, @date_time.hour)
      assert_equal(14, @date_time.minute)
      assert_equal(15, @date_time.second)
      assert_equal(16, @date_time.millis)
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

    def test_local_now_other_zone
      d = RhodaTime::LocalDateTime.now(clock=FakeClock.new(1483228800000, -18000))
      assert_equal(2016, d.year)
      assert_equal(12, d.month)
      assert_equal(31, d.day)
      assert_equal(19, d.hour)
      assert_equal(0, d.minute)
      assert_equal(0, d.second)
    end

    def test_with_year
      d = @date_time.with_year(1444)
      assert_equal(1444, d.year)
      assert_equal(12, d.month)
      assert_equal(1, d.day)
      assert_equal(13, d.hour)
      assert_equal(14, d.minute)
      assert_equal(15, d.second)
      assert_equal(16, d.millis)
    end

    def test_with_month
      d = @date_time.with_month(11)
      assert_equal(2017, d.year)
      assert_equal(11, d.month)
      assert_equal(1, d.day)
      assert_equal(13, d.hour)
      assert_equal(14, d.minute)
      assert_equal(15, d.second)
      assert_equal(16, d.millis)
    end

    def test_with_month_too_high
      assert_raises DateTimeException do
        @date_time.with_month(13)
      end
    end

    def test_with_month_too_low
      assert_raises DateTimeException do
        @date_time.with_month(0)
      end
    end

    def test_with_day
      d = @date_time.with_day(11)
      assert_equal(2017, d.year)
      assert_equal(12, d.month)
      assert_equal(11, d.day)
      assert_equal(13, d.hour)
      assert_equal(14, d.minute)
      assert_equal(15, d.second)
      assert_equal(16, d.millis)
    end

    def test_with_day_too_high
      assert_raises DateTimeException do
        @date_time.with_day(32)
      end
    end

    def test_with_day_too_low
      assert_raises DateTimeException do
        @date_time.with_day(0)
      end
    end

    def test_with_hour
      d = @date_time.with_hour(5)
      assert_equal(2017, d.year)
      assert_equal(12, d.month)
      assert_equal(1, d.day)
      assert_equal(5, d.hour)
      assert_equal(14, d.minute)
      assert_equal(15, d.second)
      assert_equal(16, d.millis)
    end

    def test_with_hour_too_high
      assert_raises DateTimeException do
        @date_time.with_hour(60)
      end
    end

    def test_with_hour_too_low
      assert_raises DateTimeException do
        @date_time.with_hour(-1)
      end
    end

    def test_with_second
      d = @date_time.with_second(5)
      assert_equal(2017, d.year)
      assert_equal(12, d.month)
      assert_equal(1, d.day)
      assert_equal(13, d.hour)
      assert_equal(14, d.minute)
      assert_equal(5, d.second)
      assert_equal(16, d.millis)
    end

    def test_with_second_too_high
      assert_raises DateTimeException do
        @date_time.with_second(60)
      end
    end

    def test_with_second_too_low
      assert_raises DateTimeException do
        @date_time.with_second(-1)
      end
    end

    def test_plus_years
      dt = @date_time.plus_years(10)
      assert_equal(2027, dt.year)
      assert_equal(12, dt.month)
      assert_equal(1, dt.day)
      assert_equal(13, dt.hour)
      assert_equal(14, dt.minute)
      assert_equal(15, dt.second)
      assert_equal(16, dt.millis)
    end

    def test_minus_years
      dt = @date_time.minus_years(10)
      assert_equal(2007, dt.year)
      assert_equal(12, dt.month)
      assert_equal(1, dt.day)
      assert_equal(13, dt.hour)
      assert_equal(14, dt.minute)
      assert_equal(15, dt.second)
      assert_equal(16, dt.millis)
    end

    def test_plus_month
      dt = @date_time.plus_months(25)
      assert_equal(2019, dt.year, "year should be 2019")
      assert_equal(1, dt.month, "month should be january")
      assert_equal(1, dt.day, "day should be the 1st")
      assert_equal(13, dt.hour)
      assert_equal(14, dt.minute)
      assert_equal(15, dt.second)
      assert_equal(16, dt.millis)

    end

    def test_plus_days
      dt = @date_time.plus_days(33)
      assert_equal(2018, dt.year)
      assert_equal(1, dt.month)
      assert_equal(3, dt.day)
      assert_equal(13, dt.hour)
      assert_equal(14, dt.minute)
      assert_equal(15, dt.second)
      assert_equal(16, dt.millis)
    end

    def test_minus_days
      dt = @date_time.minus_days(365)
      assert_equal(2016, dt.year)
      assert_equal(12, dt.month)
      assert_equal(1, dt.day)
      assert_equal(13, dt.hour)
      assert_equal(14, dt.minute)
      assert_equal(15, dt.second)
      assert_equal(16, dt.millis)
    end

    def test_hours
      dt = @date_time.plus_hours(28)
      assert_equal(2017, dt.year)
      assert_equal(12, dt.month)
      assert_equal(2, dt.day)
      assert_equal(17, dt.hour)
      assert_equal(14, dt.minute)
      assert_equal(15, dt.second)
      assert_equal(16, dt.millis)

    end

    def test_apply_offset
      dt = @date_time.apply_offset(ZoneOffset.of_time(-5))
      assert_equal(2017, dt.year)
      assert_equal(12, dt.month)
      assert_equal(1, dt.day)
      assert_equal(8, dt.hour)
      assert_equal(14, dt.minute)
      assert_equal(15, dt.second)
      assert_equal(16, dt.millis)
      assert_equal(ZoneOffset.of_time(-5), dt.offset)
    end

    def test_apply_offset2
      dt = @date_time.apply_offset(ZoneOffset.of_time(17))
      assert_equal(2017, dt.year)
      assert_equal(12, dt.month)
      assert_equal(2, dt.day)
      assert_equal(6, dt.hour)
      assert_equal(14, dt.minute)
      assert_equal(15, dt.second)
      assert_equal(16, dt.millis)
      assert_equal(ZoneOffset.of_time(17), dt.offset)
    end

    def test_plus
      dt = @date_time.plus(Duration.of_hours(13))
      assert_equal(2017, dt.year)
      assert_equal(12, dt.month)
      assert_equal(2, dt.day)
      assert_equal(2, dt.hour)
      assert_equal(14, dt.minute)
      assert_equal(15, dt.second)
      assert_equal(16, dt.millis)
    end

    def test_on_interval
      acc = ""
      @date_time.range_until(@date_time.plus_days(4))
          .on_interval(Duration.of_hours(12)) do |time|
        acc << time.to_s
      end
      assert_equal("2017-12-01T13:14:15.0162017-12-02T01:14:15.0162017-12-02T13:14:15.0162017-12-03T01:14:15.0162017-12-03T13:14:15.0162017-12-04T01:14:15.0162017-12-04T13:14:15.0162017-12-05T01:14:15.0162017-12-05T13:14:15.016", acc)
    end

    def test_inject_on_interval
      foo = @date_time.range_until(@date_time.plus_days(4))
          .inject_on_interval(Duration.of_hours(12), "") do |acc, time|
        acc << time.to_s
      end
      assert_equal("2017-12-01T13:14:15.0162017-12-02T01:14:15.0162017-12-02T13:14:15.0162017-12-03T01:14:15.0162017-12-03T13:14:15.0162017-12-04T01:14:15.0162017-12-04T13:14:15.0162017-12-05T01:14:15.0162017-12-05T13:14:15.016", foo)
    end

    ## TO_S

    def test_to_s
      assert_equal("2017-12-01T13:14:15.016", @date_time.to_s)
      assert_equal("2017-12-01T13:14:15.016", @date_time.format)
      assert_equal("13:14:15.016", @date_time.format(DateTimeFormatter::ISO_LOCAL_TIME))
      assert_equal("2017-12-01", @date_time.format(DateTimeFormatter::ISO_LOCAL_DATE))
    end
  end
end
