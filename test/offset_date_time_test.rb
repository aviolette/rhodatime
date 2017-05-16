require_relative '../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  class OffsetDateTimeTest < Minitest::Test

    def setup
      @od = OffsetDateTime.of(2015, 5, 13, 14, 15, 16, 17, ZoneOffset.of_time(-5))
    end

    def test_of_time
      assert_equal(2015, @od.year)
      assert_equal(5, @od.month)
      assert_equal(13, @od.day)
      assert_equal(14, @od.hour)
      assert_equal(15, @od.minute)
      assert_equal(16, @od.second)
      assert_equal(17, @od.millis)
      assert_equal(ZoneOffset.of_time(-5), @od.offset)
    end

    def test_equal
      assert_equal(@od, OffsetDateTime.of(2015, 5, 13, 14, 15, 16, 17, ZoneOffset.of_time(-5)))
    end

    def test_format
      assert_equal("2015-05-13T14:15:16.017-05:00", @od.format)
      assert_equal("2015-05-13T14:15:16.017-05:00", @od.to_s)
      assert_equal("2015-05-13T14:15:16.017+00:00", @od.with_offset(ZoneOffset.of_time(0)).to_s)
    end

    def test_parse
      assert_equal(@od, OffsetDateTime.parse("2015-05-13T14:15:16.017-05:00"))
    end
  end
end
