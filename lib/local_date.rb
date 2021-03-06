require 'time'
require_relative './local_date_time'
require_relative './year_month'

module RhodaTime
  # A date without a timezone or time component, representing the ISO-8601 calendar.
  class LocalDate
    attr_reader :year, :month, :day

    # Builds a [LocalDate] from the specified year-month-day
    def self.of(year, month, day)
      new(year, month, day)
    end

    # Returns a [LocalDate] on the specified clock
    def self.now(clock = Clock.instance)
      from_epoch(clock.now + (clock.offset * 1000))
    end

    # Parses a LocalDate from a string
    # @param [String] a date string (e.g. "2017-05-14")
    # @param [DateTimeFormatter] a formatter
    # @return [LocalDate] that represents the parsed string
    def self.parse(date_string, formatter = DateTimeFormatter::ISO_LOCAL_DATE)
      formatter.parse date_string, LocalDate.of(1, 1, 1)
    end

    # Builds a local date from epoch time
    # @param val [int] a millisecond representation of time from January 1, 1970
    # @return [LocalDate] a date object representing the specified epoch time with 0 TZ offset
    def self.from_epoch(val)
      # TODO: do this natively
      time = Time.at(val / 1000).getlocal(0)
      new(time.year, time.month, time.day)
    end

    # Returns a [LocalDateTime] object with the current date object at the start of the day
    def at_start_of_day
      LocalDateTime.of(year, month, day, 0, 0, 0, 0)
    end

    # Returns the number of milliseconds since epoch time (assumes start of day with no zone offset)
    def to_epoch
      at_start_of_day.to_epoch
    end

    # Returns a [LocalDateTime] object at the specified time
    # @param time [LocalTime] the time of day
    # @return [LocalDateTime] a combined date/time object
    def with_time(time)
      LocalDateTime.of(year, month, day, time.hour, time.minute, time.second, time.millis)
    end

    # Returns a new [LocalDate] with a new month
    # @param month [int] a number from 1-12
    # @return [LocalDate] a new date object with the specified month
    def with_month(month)
      ym = YearMonth.new(@year, month)
      if ym.last_day_of_month < @day
        LocalDate.of(@year, month, ym.last_day_of_month)
      else
        LocalDate.of(@year, month, @day)
      end
    end

    # Returns a new [LocalDate] with a new day
    # @param day [int] a number from 1-31
    # @return [LocalDate] a new date object with the specified day
    def with_day(day)
      LocalDate.of(@year, @month, day)
    end

    # Returns a new [LocalDate] with a new year
    # @param year [int] a number representing the year
    # @return [LocalDate] a new date object with the specified year
    def with_year(year)
      LocalDate.of(year, @month, @day)
    end

    # Returns a new [LocalDate] with the number of years added to the current date
    # @return [LocalDate] a date increased by the number of years
    def plus_years(years)
      with_year(year + years)
    end

    # Returns a new [LocalDate] with the number of years subtracted from the current date
    # @return [LocalDate] a date decreased by the number of years
    def minus_years(years)
      plus_years -years
    end

    # Returns a new [LocalDate] with the number of months added to the current date
    # @return [LocalDate] a date increased by the number of months
    def plus_months(months)
      return minus_months(months.abs) if months < 0
      diff = 12 - @month
      if months <= diff
        # represents the same calendar year
        with_month(@month + months)
      else
        # represents dates beyond the same calendar year
        month_offset = months - diff
        year_offset = [(months / 12).to_i, 1].max
        plus_years(year_offset).with_month(month_offset % 12)
      end
    end

    # Returns a new [LocalDate] with the number of months subtracted from the current date
    # @return [LocalDate] a date decreased by the number of months
    def minus_months(months)
      return plus_months(months.abs) if months < 0
      diff = month - (months % 12)
      year_offset = 0
      if diff <= 0
        diff = 12 + diff
        year_offset = 1
      end
      plus_years(-(months / 12) - year_offset).with_month(diff)
    end

    # Returns a new [LocalDate] with the number of days added to the current date
    # @return [LocalDate] a date increased by the number of days
    def plus_days(days)
      LocalDate.from_epoch(to_epoch + (days * 86400000))
    end

    # Returns a new [LocalDate] with the number of days subtracted from the current date
    # @return [LocalDate] a date decreased by the number of days
    def minus_days(days)
      plus_days -days
    end

    # Formats the date as a string (default is YYYY-MM-dd)
    # @param formatter the formatter used to build the string
    # @return the date in string format
    def format(formatter = DateTimeFormatter::ISO_LOCAL_DATE)
      formatter.format self
    end

    def to_s ; format ; end

    def ==(other)
      @year == other.year and @month == other.month and @day == other.day
    end

    private

    def initialize(year, month, day)
      raise DateTimeException, "Month needs a value between 1-12, but was #{month}" if month < 1 or month > 12
      ym = YearMonth.of(year, month)
      raise DateTimeException, "Day needs a value between 1-31, but was #{day}" if day < 1 or day > ym.last_day_of_month
      @year = year; @month = month; @day = day
    end
  end
end