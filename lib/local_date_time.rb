require 'time'
require_relative './local_date'
require_relative './local_time'

module RhodaTime
  class LocalDateTime

    def self.of(year, month, day, hour, minute, second=0, millis=0)
      self.new(LocalDate.of(year, month, day), LocalTime.of(hour, minute, second, millis))
    end

    def self.now(clock = Clock.instance)
      epoch = clock.now
      self.new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch))
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
      with_year(@date.year + years)
    end

    def minus_years(years)
      plus_years -years
    end

    def plus_months(months)
      ## implement
    end

    def minus_months(months)
      plus_months -months
    end

    def plus_days(days)
      epoch = to_epoch + (days * 86400000)
      LocalDateTime.new(LocalDate.from_epoch(epoch), @time)
    end

    def minus_days(days)
      plus_days -days
    end

    def plus_hours(hours)
      LocalDateTime.from_epoch(to_epoch + (hours * 60 * 60 * 1000))
    end

    def to_s ; format ; end

    def to_epoch
      t = Time.new(year, month, day, hour, minute, second + (millis.to_f / 1000), "+00:00")
      (t.to_f * 1000).to_i
    end

    private

    def self.from_epoch(epoch)
      LocalDateTime.new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch))
    end

    def initialize(date, time)
      @date = date
      @time = time
    end
  end
end