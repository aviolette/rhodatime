require_relative './date_time_exception'
require_relative './clock'
require_relative './date_time_formatter'

module RhodaTime

  # Represents a time independent of a day or a time zone.  A time is represented in hours, minutes, seconds, and
  # milliseconds
  class LocalTime
    attr_reader :hour, :minute, :second, :millis

    def self.now(clock = Clock.instance)
      self.from_epoch(clock.now)
    end

    def self.of(hour, minute, second = 0, millis = 0)
      self.new(hour, minute, second, millis)
    end

    # Combines this time and the date to create a date time object
    # @return [LocalDateTime] with the date and time combined
    def at_date(date)
      LocalDateTime.of(date.year, date.month, date.day, hour, minute, second, millis)
    end

    # Builds a new [LocalTime] with the specified hour, and all else the same as the current
    # @param hour [int] the specified hour
    # @return [LocalTime] the new time with a different hour
    def with_hour(hour)
      LocalTime.of(hour, @minute, @second, @millis)
    end

    # Builds a new [LocalTime] with the specified minute, and all else the same as the current
    # @param minute [int] the specified minute
    # @return [LocalTime] the new time with a different minute
    def with_minute(minute)
      LocalTime.of(@hour, minute, @second, @millis)
    end

    # Builds a new [LocalTime] with the specified second, and all else the same as the current
    # @param second [int] the specified second
    # @return [LocalTime] the new time with a different second
    def with_second(second)
      LocalTime.of(@hour, @minute, second, @millis)
    end

    # Builds a new [LocalTime] with the specified millisecond, and all else the same as the current
    # @param millis [int] the specified millisecond
    # @return [LocalTime] the new time with a different millisecond
    def with_millis(millis)
      LocalTime.of(@hour, @minute, @second, millis)
    end

    # Formats the time as a string
    # @param formatter the formatter to perform the conversion (default is ISO local time)
    # @return [String] the formatted date
    def format(formatter = DateTimeFormatter::ISO_LOCAL_TIME)
      formatter.format self
    end

    # Outputs as a string
    # @return [String] the time formatted in ISO local time
    def to_s ; format ; end

    # Returns true if the other time is after the current time (no consideration to day is given)
    # @param other [LocalTime] another time object
    # @return [true, false] true if the other time is after the current time, or false if it is the same time or before
    def after?(other)
      if other.hour < @hour
        return true
      elsif other.hour == @hour
        if other.minute < @minute
          return true
        elsif other.minute == @minute
          if other.second < @second
            return true
          elsif other.second == @second
            return other.millis < @millis
          end
        end
      end
      false
    end

    # Returns true if this time and another time represent the same time
    # @param other [LocalTime] another time object
    # @return [true, false] true if the other time has the same time values as the current
    def same?(other)
      other.hour == @hour and other.minute == @minute and other.second == @second and other.millis == @millis
    end

    # Returns true if the other time is before the current time
    # @param other [LocalTime] another time object
    # @return [true, false] true if the other time is before this time
    def before?(other)
      !same?(other) and !after?(other)
    end

    private

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

    def initialize(hour, minute, second = 0, millis = 0)
      raise DateTimeException, "Hour is not in range: #{hour}" if hour < 0 || hour > 23
      raise DateTimeException, "Minute is not in range: #{minute}" if minute < 0 || minute > 59
      raise DateTimeException, "Second is not in range: #{second}" if second < 0 || second > 59
      raise DateTimeException, "Milliseconds is not in range: #{second}" if millis < 0 || millis > 999
      @hour = hour; @minute = minute; @second = second; @millis = millis
    end
  end
end