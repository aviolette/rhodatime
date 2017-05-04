require_relative '../lib/rhodatime'
require 'minitest/autorun'

module RhodaTime
  class TestLocalDateFormatter < Minitest::Test

    def setup
      @date1 = LocalDate.of(2017, 1, 6)
      @date_time1 = LocalDateTime.of(2017, 1, 6, 9, 13, 14, 153)
    end

    def test_local_date
      formatter = DateTimeFormatter::ISO_LOCAL_DATE
      assert_equal("2017-01-06", formatter.format(@date1))
    end

    def test_local_date_time
      formatter = DateTimeFormatter::ISO_LOCAL_DATE
      assert_equal("2017-01-06", formatter.format(@date_time1))
    end

    def test_yyyy
      formatter = DateTimeFormatter.new("YYYY")
      assert_equal("2017", formatter.format(@date1))
    end

    def test_yyy
      formatter = DateTimeFormatter.new("YYY")
      assert_equal("2017", formatter.format(@date1))
    end

    def test_yy
      formatter = DateTimeFormatter.new("YY")
      assert_equal("17", formatter.format(@date1))
    end

    def test_y
      formatter = DateTimeFormatter.new("Y")
      assert_equal("17", formatter.format(@date1))
    end
    
    def test_mmmmm
      formatter = DateTimeFormatter.new("MMMMM")
      assert_equal("J", formatter.format(@date1))
    end

    def test_mmmm_january
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("January", formatter.format(@date1.with_month(1)))
    end

    def test_mmmm_february
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("February", formatter.format(@date1.with_month(2)))
    end

    def test_mmmm_march
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("March", formatter.format(@date1.with_month(3)))
    end

    def test_mmmm_april
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("April", formatter.format(@date1.with_month(4)))
    end

    def test_mmmm_may
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("May", formatter.format(@date1.with_month(5)))
    end

    def test_mmmm_june
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("June", formatter.format(@date1.with_month(6)))
    end

    def test_mmmm_july
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("July", formatter.format(@date1.with_month(7)))
    end

    def test_mmmm_august
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("August", formatter.format(@date1.with_month(8)))
    end

    def test_mmmm_september
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("September", formatter.format(@date1.with_month(9)))
    end

    def test_mmmm_october
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("October", formatter.format(@date1.with_month(10)))
    end

    def test_mmmm_november
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("November", formatter.format(@date1.with_month(11)))
    end

    def test_mmmm_december
      formatter = DateTimeFormatter.new("MMMM")
      assert_equal("December", formatter.format(@date1.with_month(12)))
    end

    def test_mmm
      formatter = DateTimeFormatter.new("MMM")
      assert_equal("Dec", formatter.format(@date1.with_month(12)))
    end

    def test_mm
      formatter = DateTimeFormatter.new("MM")
      assert_equal("12", formatter.format(@date1.with_month(12)))
    end

    def test_mm_1
      formatter = DateTimeFormatter.new("MM")
      assert_equal("01", formatter.format(@date1.with_month(1)))
    end

    def test_m
      formatter = DateTimeFormatter.new("M")
      assert_equal("1", formatter.format(@date1.with_month(1)))
    end

    def test_dd
      formatter = DateTimeFormatter.new("dd")
      assert_equal("06", formatter.format(@date1))
    end

    def test_d
      formatter = DateTimeFormatter.new("d")
      assert_equal("6", formatter.format(@date1))
    end

    def test_local_time_all_ops
      assert_equal("09:13:14.153", DateTimeFormatter::ISO_LOCAL_TIME.format(@date_time1))
    end

    def test_local_time_no_millis
      assert_equal("09:13:14", DateTimeFormatter::ISO_LOCAL_TIME.format(@date_time1.with_millis(0)))
    end

    def test_local_time_no_seconds
      assert_equal("09:13", DateTimeFormatter::ISO_LOCAL_TIME.format(@date_time1.with_millis(0).with_seconds(0)))
    end

    def test_local_time_no_minutes
      assert_equal("09:00", DateTimeFormatter::ISO_LOCAL_TIME.format(@date_time1.with_millis(0).with_seconds(0).with_minutes(0)))
    end

  end
end