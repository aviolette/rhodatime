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

    def test_to_s
      assert_equal("2017-12-01T13:14:15.016", @date_time.to_s)
      assert_equal("2017-12-01T13:14:15.016", @date_time.format)
      assert_equal("13:14:15.016", @date_time.format(DateTimeFormatter::ISO_LOCAL_TIME))
      assert_equal("2017-12-01", @date_time.format(DateTimeFormatter::ISO_LOCAL_DATE))
    end
  end
end
