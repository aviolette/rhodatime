require_relative '../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  class TestZoneOffset < Minitest::Test

    def test_of_time
      zone = ZoneOffset.of_time(0)
      assert_equal(0, zone.offset_seconds)
    end

    def test_of_time_hours
      zone = ZoneOffset.of_time(5)
      assert_equal(18000, zone.offset_seconds)
    end

    def test_of_time_hours_negative
      zone = ZoneOffset.of_time(-5)
      assert_equal(-18000, zone.offset_seconds)
    end

    def test_of_time_hours_out_of_bounds
      assert_raises DateTimeException do
        ZoneOffset.of_time(19)
      end
    end

    def test_format
      assert_equal("+05:00", ZoneOffset.of_time(5).format)
      assert_equal("-05:00", ZoneOffset.of_time(-5).format)
      assert_equal("-05:45", ZoneOffset.of_time(-5, 45).format)
      assert_equal("+00:00", ZoneOffset.of_time(0).format)
    end
  end
end
