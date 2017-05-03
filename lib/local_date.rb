require 'time'
require_relative './local_date_time'

module RhodaTime
  class LocalDate
    attr_reader :year, :month, :day

    def self.of(year, month, day)
      self.new(year, month, day)
    end

    def self.now(clock = RealClock.instance)
      self.from_epoch(clock.now)
    end

    def self.from_epoch(val)
      # TODO: do this natively
      time = Time.at(val / 1000).getlocal(0)
      self.new(time.year, time.month, time.day)
    end

    def at_start_of_day
      LocalDateTime.of(year, month, day, 0, 0, 0, 0)
    end

    def with_time(time)
      LocalDateTime.of(year, month, day, time.hour, time.minute, time.second, time.millis)
    end

    private

    def initialize(year, month, day)
      @year = year; @month = month; @day = day
    end
  end
end