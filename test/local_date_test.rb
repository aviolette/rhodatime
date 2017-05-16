require_relative './fake_clock'
require_relative '../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  class TestLocalDate < Minitest::Test
    ## OF

    def test_local_of
      d = LocalDate.of(2017, 12, 1)
      assert_equal(2017, d.year)
      assert_equal(12, d.month)
      assert_equal(1, d.day)
    end

    def test_local_now
      d = LocalDate.now(FakeClock.new(1483228800000))
      assert_equal(2017, d.year)
      assert_equal(1, d.month)
      assert_equal(1, d.day)
    end

    ## NOW

    def test_local_now2
      d = LocalDate.now(FakeClock.new(1514764800000))
      assert_equal(2018, d.year)
      assert_equal(1, d.month)
      assert_equal(1, d.day)
    end

    def test_local_now3
      d = LocalDate.now(FakeClock.new(1514757599000))
      assert_equal(2017, d.year)
      assert_equal(12, d.month)
      assert_equal(31, d.day)
    end


    def test_local_now_other_zone
      d = RhodaTime::LocalDate.now(clock=FakeClock.new(1483228800000, -18000))
      assert_equal(2016, d.year)
      assert_equal(12, d.month)
      assert_equal(31, d.day)
    end

    ## AT START OF DAY

    def test_at_start_of_day
      d = LocalDate.now(FakeClock.new(1514757599000))
      dt = d.at_start_of_day
      assert_equal(2017, dt.year)
      assert_equal(12, dt.month)
      assert_equal(31, dt.day)
      assert_equal(0, dt.hour)
      assert_equal(0, dt.minute)
      assert_equal(0, dt.second)
      assert_equal(0, dt.millis)
    end

    ## WITH_TIME

    def test_with_local_time
      d = LocalDate.of(2017, 3, 14)
      dt = d.with_time(LocalTime.of(2, 3, 4, 5))
      assert_equal(2017, dt.year)
      assert_equal(3, dt.month)
      assert_equal(14, dt.day)
      assert_equal(2, dt.hour)
      assert_equal(3, dt.minute)
      assert_equal(4, dt.second)
      assert_equal(5, dt.millis)
    end

    ## WITH_YEAR

    def test_with_year
      d = LocalDate.of(2018, 3, 14).with_year(2018)
      assert_equal(2018, d.year)
      assert_equal(3, d.month)
      assert_equal(14, d.day)
    end
    
    ## WITH_MONTH

    def test_with_month
      d = LocalDate.of(2017, 3, 14).with_month(4)
      assert_equal(2017, d.year)
      assert_equal(4, d.month)
      assert_equal(14, d.day)
    end

    def test_with_month_too_high
      assert_raises DateTimeException do
        LocalDate.of(2017, 3, 14).with_month(13)
      end
    end

    def test_with_month_too_low
      assert_raises DateTimeException do
        LocalDate.of(2017, 3, 14).with_month(0)
      end
    end

    ## WITH_DAY

    def test_with_day
      d = LocalDate.of(2017, 3, 14).with_day(30)
      assert_equal(2017, d.year)
      assert_equal(3, d.month)
      assert_equal(30, d.day)
    end

    def test_with_day_too_high
      assert_raises DateTimeException do
        LocalDate.of(2017, 3, 14).with_day(32)
      end
    end

    def test_with_day_too_low
      assert_raises DateTimeException do
        LocalDate.of(2017, 3, 14).with_day(0)
      end
    end

    ## TO_S

    def test_to_s
      d = LocalDate.of(2017, 3, 14)
      assert_equal("2017-03-14", d.to_s)
      assert_equal("2017-03-14", d.format)
      assert_equal("2017-03-14", d.format(DateTimeFormatter::ISO_LOCAL_DATE))
    end

    ## EQUAL

    def test_equal
      assert_equal(LocalDate.of(2017, 3, 14), LocalDate.of(2017, 3, 14))
      assert(LocalDate.of(2017, 3, 14) != LocalDate.of(2017,2, 14))
      assert(LocalDate.of(2017, 3, 14) == LocalDate.of(2017,3, 14))
    end

    ## PLUS_*

    def test_plus_years
      d = LocalDate.of(2017, 3, 14)
      assert_equal(LocalDate.of(2021, 3, 14), d.plus_years(4))
    end

    def test_plus_months
      d = LocalDate.of(2017, 3, 14)
      assert_equal(LocalDate.of(2018, 3, 14), d.plus_months(12))
      assert_equal(LocalDate.of(2018, 4, 14), d.plus_months(13))
      assert_equal(LocalDate.of(2018, 5, 14), d.plus_months(14))
      assert_equal(d, d.plus_months(0))
    end

    def test_minus_months
      d = LocalDate.of(2017, 3, 14)
      assert_equal(LocalDate.of(2017, 2, 14), d.minus_months(1))
      assert_equal(LocalDate.of(2017, 1, 14), d.minus_months(2))
      assert_equal(LocalDate.of(2016, 12, 14), d.minus_months(3))
      assert_equal(LocalDate.of(2016, 11, 14), d.minus_months(4))
      assert_equal(LocalDate.of(2016, 10, 14), d.minus_months(5))
      assert_equal(LocalDate.of(2016, 9, 14), d.minus_months(6))
      assert_equal(LocalDate.of(2016, 8, 14), d.minus_months(7))
      assert_equal(LocalDate.of(2016, 7, 14), d.minus_months(8))
      assert_equal(LocalDate.of(2016, 6, 14), d.minus_months(9))
      assert_equal(LocalDate.of(2016, 5, 14), d.minus_months(10))
      assert_equal(LocalDate.of(2016, 4, 14), d.minus_months(11))
      assert_equal(LocalDate.of(2016, 3, 14), d.minus_months(12))
      assert_equal(LocalDate.of(2016, 2, 14), d.minus_months(13))
      assert_equal(LocalDate.of(2014, 3, 14), d.minus_months(36))
      assert_equal(LocalDate.of(2014, 4, 14), d.minus_months(35))
    end
  end
end
