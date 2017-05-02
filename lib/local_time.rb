require_relative './date_time_exception'
require_relative './real_clock'

module RhodaTime
  class LocalTime
    attr_reader :hour, :minute, :second, :millis

    def self.now(clock = RealClock.instance)
      self.from_epoch(clock.now)
    end

    # Returns a new LocalTime initializes with epoch time and the default time zone
    def self.from_epoch(epoch)
      epoch_in_seconds = epoch / 1000
      millis = epoch % 1000
      days_from_epoch = epoch_in_seconds / 86400
      seconds_from_start_of_day = epoch_in_seconds - (86400 * days_from_epoch)
      hours_in_day = seconds_from_start_of_day / 3600
      minutes_in_hour = (seconds_from_start_of_day % 3600) / 60
      seconds_in_minutes = (seconds_from_start_of_day - (hours_in_day * 3600) - (minutes_in_hour * 60))
      self.new(hours_in_day, minutes_in_hour, seconds_in_minutes, millis)
    end

    def self.of(hour, minute, second = 0, millis = 0)
      self.new(hour, minute, second, millis)
    end

    def to_s
      if @millis == 0
        if @second == 0
          sprintf("%02d:%02d", @hour, @minute)
        else
          sprintf("%02d:%02d:%2d", @hour, @minute, @second)
        end
      else
        sprintf("%02d:%02d:%02d.%03d", @hour, @minute, @second, @millis)
      end
    end

    def after?(other)
      if other.hour < @hour
        true
      elsif other.hour == @hour
        if other.minute < @minute
          true
        elsif other.minute == @minute
          return other.second < @second
        else
          false
        end
      else
        false
      end
    end

    def before?(other)

    end

    def minus(other)

    end

    def minusHours(hours)

    end

    def minusMinutes(minutes)

    end

    def minusSeconds(seconds)

    end

    private

    def initialize(hour, minute, second = 0, millis = 0)
      raise DateTimeException, "Hour is not in range: #{hour}" if hour < 0 || hour > 23
      raise DateTimeException, "Minute is not in range: #{minute}" if minute < 0 || minute > 59
      raise DateTimeException, "Second is not in range: #{second}" if second < 0 || second > 59
      raise DateTimeException, "Milliseconds is not in range: #{second}" if millis < 0 || millis > 999
      @hour = hour; @minute = minute; @second = second; @millis = millis
    end

    def self.hours_from_epoch(epoch)

    end

    def self.minutes_from_epoch(epoch)

    end
  end
end