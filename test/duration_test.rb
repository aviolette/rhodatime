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

    def test_to_s
      assert_equal("PT23.456S", Duration.of_millis(23456).to_s)
      assert_equal("PT15M", Duration.of_minutes(15).to_s)
      assert_equal("PT10H", Duration.of_hours(10).to_s)
      assert_equal("PT48H", Duration.of_days(2).to_s)
      assert_equal("PT48H10M55.345S", Duration.of_days(2).plus_minutes(10).plus_seconds(55).plus_millis(345).to_s)
    end
  end
end
