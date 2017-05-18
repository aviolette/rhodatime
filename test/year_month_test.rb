require_relative '../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  class TestYearMonth < Minitest::Test

    def test_of
      ym = YearMonth.of(2015, 1)
      assert_equal(2015, ym.year)
      assert_equal(1, ym.month)
    end

    def test_of_low_month
      assert_raises DateTimeException do
        YearMonth.of(2015, 0)
      end
    end

    def test_of_high_month
      assert_raises DateTimeException do
        YearMonth.of(2015, 13)
      end
    end

    def test_last_day_of_month_jan
      assert_equal(31, YearMonth.of(2015, 1).last_day_of_month)
    end

    def test_last_day_of_month_feb_non_leap
      assert_equal(28, YearMonth.of(2015, 2).last_day_of_month)
    end

    def test_last_day_of_month_feb_leap
      assert_equal(29, YearMonth.of(2016, 2).last_day_of_month)
    end

    def test_last_day_of_month_mar
      assert_equal(31, YearMonth.of(2015, 3).last_day_of_month)
    end

    def test_last_day_of_month_apr
      assert_equal(30, YearMonth.of(2015, 4).last_day_of_month)
    end

    def test_last_day_of_month_may
      assert_equal(31, YearMonth.of(2015, 5).last_day_of_month)
    end

    def test_last_day_of_month_june
      assert_equal(30, YearMonth.of(2015, 6).last_day_of_month)
    end

    def test_last_day_of_month_jul
      assert_equal(31, YearMonth.of(2015, 7).last_day_of_month)
    end

    def test_last_day_of_month_aug
      assert_equal(31, YearMonth.of(2015, 8).last_day_of_month)
    end

    def test_last_day_of_month_sep
      assert_equal(30, YearMonth.of(2015, 9).last_day_of_month)
    end

    def test_last_day_of_month_oct
      assert_equal(31, YearMonth.of(2015, 10).last_day_of_month)
    end

    def test_last_day_of_month_nov
      assert_equal(30, YearMonth.of(2015, 11).last_day_of_month)
    end

    def test_last_day_of_month_dec
      assert_equal(31, YearMonth.of(2015, 12).last_day_of_month)
    end

    def test_leap
      assert_equal(true, YearMonth.of(2016, 12).leap_year?)
      assert_equal(false, YearMonth.of(2015, 12).leap_year?)
    end
  end
end
