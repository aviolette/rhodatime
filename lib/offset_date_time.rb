require 'time'
require_relative './local_date_time'
require_relative './zone_offset'

module RhodaTime
  class OffsetDateTime < LocalDateTime

    attr_reader :offset

    def self.of(year, month, day, hour, minute, second, millis, offset)
      self.new(LocalDate.of(year, month, day), LocalTime.of(hour, minute, second, millis), offset)
    end

    def self.of_epoch(epoch, offset)
      epoch = epoch + (offset.offset_seconds * 1000)
      self.new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch), offset)
    end

    def self.now(clock = Clock.instance)
      of_epoch clock.now, ZoneOffset.from_seconds(clock.offset)
    end

    def self.parse(date_time_string, formatter = DateTimeFormatter::ISO_OFFSET_DATE_TIME)
      formatter.parse date_time_string, OffsetDateTime.of(1, 1, 1, 0, 0, 0, 0, ZoneOffset::UTC)
    end

    def with_year(year)
      OffsetDateTime.new(@date.with_year(year), @time, @offset)
    end

    def with_month(month)
      OffsetDateTime.new(@date.with_month(month), @time, @offset)
    end

    def with_day(day)
      OffsetDateTime.new(@date.with_day(day), @time, @offset)
    end

    def with_hour(hour)
      OffsetDateTime.new(@date, @time.with_hour(hour), @offset)
    end

    def with_minute(minutes)
      OffsetDateTime.new(@date, @time.with_minute(minutes), @offset)
    end

    def with_second(seconds)
      OffsetDateTime.new(@date, @time.with_second(seconds), @offset)
    end

    def with_millis(millis)
      OffsetDateTime.new(@date, @time.with_millis(millis), @offset)
    end

    def with_offset(offset)
      OffsetDateTime.new(@date, @time, offset)
    end

    def format(formatter = DateTimeFormatter::ISO_OFFSET_DATE_TIME)
      formatter.format self
    end

    def plus_years(years)
      OffsetDateTime.new(@date.plus_years(years), @time, @offset)
    end

    def plus_months(months)
      OffsetDateTime.new(@date.plus_months(months), @time, @offset)
    end

    def plus_days(days)
      OffsetDateTime.new(@date.plus_days(days), @time, @offset)
    end

    def plus_hours(hours)
      self.of_epoch_with_no_adjustment(to_epoch + (hours * 60 * 60 * 1000), @offset)
    end

    def offset_seconds
      @offset.offset_seconds
    end

    def ==(other)
      @date == other.date and @time == other.time and @offset == other.offset
    end

    def to_s ; format ; end

    private

    def self.of_epoch_with_no_adjustment(epoch, offset)
      self.new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch), offset)
    end

    def tz_format ; @offset.format ; end

    def initialize(date, time, offset)
      super(date, time)
      @offset = offset
    end
  end
end