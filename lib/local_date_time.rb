require 'time'
require_relative './local_date'
require_relative './local_time'
require_relative './temporal'
module RhodaTime
  class LocalDateTime
    include Temporal

    attr_reader :date, :time

    def self.of(year, month, day, hour, minute, second=0, millis=0)
      self.new(LocalDate.of(year, month, day), LocalTime.of(hour, minute, second, millis))
    end

    def self.now(clock = Clock.instance)
      epoch = clock.now + (clock.offset * 1000)
      self.new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch))
    end

    def self.parse(date_time_string, formatter = DateTimeFormatter::ISO_LOCAL_DATE_TIME)
      formatter.parse date_time_string, LocalDateTime.of(1, 1, 1, 0, 0)
    end

    def year ; @date.year ; end

    def month ; @date.month ; end

    def day ; @date.day ; end

    def hour ; @time.hour ; end

    def minute ; @time.minute ; end

    def second ; @time.second ; end

    def millis ; @time.millis ; end

    def with_year(year)
      LocalDateTime.new(@date.with_year(year), @time)
    end

    def with_month(month)
      LocalDateTime.new(@date.with_month(month), @time)
    end

    def with_day(day)
      LocalDateTime.new(@date.with_day(day), @time)
    end

    def with_hour(hour)
      LocalDateTime.new(@date, @time.with_hour(hour))
    end

    def with_minute(minutes)
      LocalDateTime.new(@date, @time.with_minute(minutes))
    end

    def with_second(seconds)
      LocalDateTime.new(@date, @time.with_second(seconds))
    end

    def with_millis(millis)
      LocalDateTime.new(@date, @time.with_millis(millis))
    end

    def format(formatter = DateTimeFormatter::ISO_LOCAL_DATE_TIME)
      formatter.format self
    end

    def plus_years(years)
      LocalDateTime.new(@date.plus_years(years), @time)
    end

    def minus_years(years)
      plus_years -years
    end

    def plus_months(months)
      LocalDateTime.new(@date.plus_months(months), @time)
    end

    def minus_months(months)
      plus_months -months
    end

    def apply_offset(offset)
      OffsetDateTime.of_epoch(to_epoch, offset)
    end

    def after?(other)
      to_epoch > other.to_epoch
    end

    def to_s ; format ; end

    def to_epoch
      t = Time.new(year, month, day, hour, minute, second + (millis.to_f / 1000), tz_format)
      (t.to_f * 1000).to_i
    end

    def range_until(end_time)
      TimeRange.new(self, end_time)
    end

    private

    def tz_format
      "+00:00"
    end

    def self.from_epoch_with_self(epoch, current)
      from_epoch(epoch)
    end

    def self.from_epoch(epoch)
      LocalDateTime.new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch))
    end

    def initialize(date, time)
      @date = date
      @time = time
    end
  end
end