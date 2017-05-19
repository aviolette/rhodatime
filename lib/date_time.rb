require 'time'
require_relative './local_date'
require_relative './local_time'
require_relative './temporal'

module RhodaTime
  class DateTime
    include Temporal

    attr_reader :date, :time

    def year ; @date.year ; end

    def month ; @date.month ; end

    def day ; @date.day ; end

    def hour ; @time.hour ; end

    def minute ; @time.minute ; end

    def second ; @time.second ; end

    def millis ; @time.millis ; end

    def with_year(year)
      self.class.from_date_time_with_self(@date.with_year(year), @time, self)
    end

    def with_month(month)
      self.class.from_date_time_with_self(@date.with_month(month), @time, self)
    end

    def with_day(day)
      self.class.from_date_time_with_self(@date.with_day(day), @time, self)
    end

    def with_hour(hour)
      self.class.from_date_time_with_self(@date, @time.with_hour(hour), self)
    end

    def with_minute(minutes)
      self.class.from_date_time_with_self(@date, @time.with_minute(minutes), self)
    end

    def with_second(seconds)
      self.class.from_date_time_with_self(@date, @time.with_second(seconds), self)
    end

    def with_millis(millis)
      self.class.from_date_time_with_self(@date, @time.with_millis(millis), self)
    end

    def plus_years(years)
      self.class.from_date_time_with_self(@date.plus_years(years), @time, self)
    end

    def minus_years(years)
      plus_years -years
    end

    def plus_months(months)
      self.class.from_date_time_with_self(@date.plus_months(months), @time, self)
    end

    def minus_months(months)
      plus_months -months
    end

    def range_until(end_time)
      TimeRange.new(self, end_time)
    end

    private

    def self.from_epoch_with_self(epoch, current)
      raise DateTimeException, "Not implemented in DateTime: subclass this class and implement"
    end

    def self.from_date_time_with_self(date, time, current)
      raise DateTimeException, "Not implemented in DateTime: subclass this class and implement"
    end

    def initialize(date, time)
      @date = date
      @time = time
    end
  end
end