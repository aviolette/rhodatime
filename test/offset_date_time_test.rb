require_relative '../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  class OffsetDateTimeTest < Minitest::Test

    def test_of_time
      od = OffsetDateTime.of(2015, 5, 13, 14, 15, 16, 17, ZoneOffset.of_time(-5))
      assert_equal(2015, od.year)
      assert_equal(5, od.month)
      assert_equal(13, od.day)
      assert_equal(14, od.hour)
      assert_equal(15, od.minute)
      assert_equal(16, od.second)
      assert_equal(17, od.millis)
      assert_equal(ZoneOffset.of_time(-5), od.offset)
    end
  end
end
