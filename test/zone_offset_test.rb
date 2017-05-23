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
      assert_equal(ZoneOffset.of_time(0), ZoneOffset.of("Z"))
    end

    def test_of_offset
      assert_equal(ZoneOffset.of_time(-1), ZoneOffset.of('UT-01:00'))
      assert_equal(ZoneOffset.of_time(1), ZoneOffset.of('UT+01:00'))
      assert_equal(ZoneOffset.of_time(-1), ZoneOffset.of('GMT-01:00'))
      assert_equal(ZoneOffset.of_time(9), ZoneOffset.of('UTC+09:00'))
      assert_equal(ZoneOffset.of_time(-9), ZoneOffset.of('UTC-09:00'))
      assert_nil(ZoneOffset.of('UT-01:00').name)
    end

    def test_of_offset_dd
      assert_equal(ZoneOffset.of_time(13), ZoneOffset.of('GMT+13:00'))
    end

    def test_of_three_letter_code_notfound
      assert_raises DateTimeException do
        ZoneOffset.of('FOO')
      end
    end

=begin
    def test_of_three_letter_code
      assert_equal(ZoneOffset.of_time(8), ZoneOffset.of('CTT'))
      assert_equal('Asia/Shanghai', ZoneOffset.of('CTT').name)
    end
=end

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
