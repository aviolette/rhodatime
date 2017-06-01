require_relative './fake_clock'
require_relative '../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  class TestDuration < Minitest::Test

    def test_of_millis
      assert_equal(66000, Duration.of_millis(66000).to_millis)
    end

    def test_of_seconds
      assert_equal(30000, Duration.of_seconds(30).to_millis)
    end

    def test_of_minutes
      assert_equal(1800000, Duration.of_minutes(30).to_millis)
    end

    def test_of_days
      assert_equal(259200000, Duration.of_days(3).to_millis)
    end

    def test_plus_minutes
      assert_equal(2100000, Duration.of_minutes(30).plus_minutes(5).to_millis)
      assert_equal(2100000, Duration.of_minutes(30).plus_minutes(5.234).to_millis)
      assert_equal(1500000, Duration.of_minutes(30).plus_minutes(-5.234).to_millis)
    end

    def test_plus_seconds
      assert_equal(1805000, Duration.of_minutes(30).plus_seconds(5).to_millis)
      assert_equal(1795000, Duration.of_minutes(30).plus_seconds(-5).to_millis)
      assert_equal(1805000, Duration.of_minutes(30).plus_seconds(5.234).to_millis)
    end

    def test_plus_hours
      assert_equal(19800000, Duration.of_minutes(30).plus_hours(5).to_millis)
      assert_equal(19800000, Duration.of_minutes(30).plus_hours(5.234).to_millis)
    end

    def test_to_s
      assert_equal("PT23.456S", Duration.of_millis(23456).to_s)
      assert_equal("PT15M", Duration.of_minutes(15).to_s)
      assert_equal("PT10H", Duration.of_hours(10).to_s)
      assert_equal("PT48H", Duration.of_days(2).to_s)
      assert_equal("PT48H10M55.345S", Duration.of_days(2).plus_minutes(10).plus_seconds(55).plus_millis(345).to_s)
      assert_equal("-PT23.456S", Duration.of_millis(-23456).to_s)
    end

    def test_negated
      assert_equal("-PT23.456S", Duration.of_millis(23456).negated.to_s)
      assert_equal(false, Duration.of_millis(23456).negative?)
      assert_equal(true, Duration.of_millis(-23456).negative?)
    end

    def test_abs
      assert_equal(Duration.of_millis(23456), Duration.of_millis(-23456).abs)
      assert_equal(Duration.of_millis(23456), Duration.of_millis(23456).abs)
    end

    def test_negative?
      assert_equal(true, Duration.of_millis(-2345).negative?)
      assert_equal(false, Duration::ZERO.negative?)
      assert_equal(false, Duration.of_millis(2345).negative?)
    end

    def test_equal
      assert_equal(Duration.of_millis(123456), Duration.of_millis(123456))
      assert_equal(Duration.of_millis(0), Duration.of_millis(0))
    end

    def test_multiply_by
      assert_equal(Duration::ZERO, Duration::ZERO.multiply_by(5))
      assert_equal(Duration::ZERO, Duration::ZERO * 0)
      assert_equal(Duration.of_millis(25), Duration.of_millis(5) * 5)
      assert_equal(Duration.of_millis(25), Duration.of_millis(5).multiply_by(5))
    end

    def test_divide_by
      assert_equal(Duration::ZERO, Duration::ZERO.divide_by(1))
      assert_raises ZeroDivisionError do
        Duration.of_millis(5) / 0
      end
      assert_raises ZeroDivisionError do
        Duration::ZERO.divide_by(0)
      end
      assert_equal(Duration.of_millis(5), Duration.of_millis(25) / 5)
      assert_equal(Duration.of_millis(5), Duration.of_millis(25).divide_by(5))
    end
  end
end
