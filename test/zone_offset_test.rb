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

    def test_equal
      assert_equal(ZoneOffset::UTC, ZoneOffset.of_time(0))
      assert_equal(ZoneOffset.of_time(5), ZoneOffset.of_time(5))
    end

    def test_of_utcs
      assert_equal("+00:00", ZoneOffset.of("Z").to_s)
      assert_equal(ZoneOffset::UTC, ZoneOffset.of("Z"))
      assert_equal(ZoneOffset::UTC, ZoneOffset.of("UT-"))
      assert_equal(ZoneOffset::UTC, ZoneOffset.of("UT+"))
      assert_equal(ZoneOffset::UTC, ZoneOffset.of("GMT+"))
      assert_equal(ZoneOffset::UTC, ZoneOffset.of("GMT-"))
      assert_equal(ZoneOffset::UTC, ZoneOffset.of("UTC+"))
      assert_equal(ZoneOffset::UTC, ZoneOffset.of("UTC-"))
    end

    def test_parse_bad_format
      assert_raises DateTimeException do
        ZoneOffset.parse("foobar")
      end
    end

    def test_of_zone_format
      assert_equal("+05:00", ZoneOffset.of("+05:00").to_s)
    end

    def test_parse
      assert_equal(ZoneOffset.of_time(5), ZoneOffset.parse("+05:00"))
      assert_equal(ZoneOffset.of_time(-5), ZoneOffset.parse("-05:00"))
    end

    def test_format
      assert_equal("+05:00", ZoneOffset.of_time(5).format)
      assert_equal("-05:00", ZoneOffset.of_time(-5).format)
      assert_equal("-05:45", ZoneOffset.of_time(-5, 45).format)
      assert_equal("+00:00", ZoneOffset.of_time(0).format)
    end
  end
end
