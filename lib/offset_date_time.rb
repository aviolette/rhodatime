require 'time'
require_relative './local_date_time'
require_relative './zone_offset'
require_relative './date_time'

module RhodaTime
  class OffsetDateTime < DateTime

    attr_reader :offset

    def self.of(year, month, day, hour, minute, second, millis, offset)
      new(LocalDate.of(year, month, day), LocalTime.of(hour, minute, second, millis), offset)
    end

    def self.of_epoch(epoch, offset)
      epoch = epoch + (offset.offset_seconds * 1000)
      new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch), offset)
    end

    def self.now(clock = Clock.instance)
      of_epoch clock.now, ZoneOffset.from_seconds(clock.offset)
    end

    def self.parse(date_time_string, formatter = DateTimeFormatter::ISO_OFFSET_DATE_TIME)
      formatter.parse date_time_string, OffsetDateTime.of(1, 1, 1, 0, 0, 0, 0, ZoneOffset::UTC)
    end

    def format(formatter = DateTimeFormatter::ISO_OFFSET_DATE_TIME)
      formatter.format self
    end

    def with_offset(offset)
      OffsetDateTime.new(@date, @time, offset)
    end

    def offset_seconds
      @offset.offset_seconds
    end

    def ==(other)
      @date == other.date and @time == other.time and @offset == other.offset
    end

    def to_s ; format ; end

    private

    def self.from_epoch_with_self(epoch, current)
      of_epoch_with_no_adjustment(epoch, current)
    end

    def self.of_epoch_with_no_adjustment(epoch, offset)
      new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch), offset)
    end

    def self.from_date_time_with_self(date, time, current)
      new(date, time, current.offset)
    end

    def tz_format ; @offset.format ; end

    def initialize(date, time, offset)
      super(date, time)
      @offset = offset
    end
  end
end