require 'time'

module RhodaTime
  # A duration represents elapsed time in millisecond precision
  class Duration

    # Builds a [Duration] from the specified number of milliseconds
    # @param millis [int] the number of milliseconds in this duration
    # @return [Duration] a new Duration object with the specified number of milliseconds
    def self.of_millis(millis)
      new(millis.to_i)
    end

    def initialize(millis = 0)
      @millis = millis
    end

    ZERO = Duration.new

    # Builds a [Duration] from the specified number of seconds
    # @param seconds [int] the number of seconds in this duration
    # @return [Duration] a new Duration object form the specified number of seconds
    def self.of_seconds(seconds)
      new(seconds.to_i * SECONDS)
    end

    # Builds a [Duration] from the specified number of minutes
    # @param minutes [int] the number of minutes in this duration
    # @return [Duration] a new Duration object from the specified number of minutes
    def self.of_minutes(minutes)
      new(minutes.to_i * MINUTES)
    end

    # Builds a [Duration] from the specified number of hours
    # @param hours [int] the number of hours in this duration
    # @return [Duration] a new Duration object from the specified number of hours
    def self.of_hours(hours)
      new(hours.to_i * HOURS)
    end

    # Builds a [Duration] from the specified number of days
    # @param days [int] the number of days in this duration
    # @return [Duration] a new Duration object from the specified number of days
    def self.of_days(days)
      new(days * DAYS)
    end

    # Adds minutes to the current duration
    # @param minutes [int] the number of minutes to add to this duration
    # @return [Duration] a new Duration object
    def plus_minutes(minutes)
      Duration.new(@millis + (minutes.to_i * MINUTES))
    end

    # Adds hours to the current duration
    # @param hours [int] the number of hours to add to this duration
    # @return [Duration] a new Duration object
    def plus_hours(hours)
      Duration.new(@millis + (hours.to_i * HOURS))
    end

    # Adds seconds to the current duration
    # @param seconds [int] the number of seconds to add to this duration
    # @return [Duration] a new Duration object
    def plus_seconds(seconds)
      Duration.new(@millis + (seconds.to_i * SECONDS))
    end

    def plus_millis(millis)
      Duration.new(@millis + millis)
    end

    # Returns the number of milliseconds in this duration
    def to_millis
      @millis
    end

    # Returns a new duration with the opposite sign of the current duration
    def negated
      Duration.new(-@millis)
    end

    # Returns a new duration with the same scalar value but with a positive sign
    def abs
      negative? ? Duration.of_millis(@millis.abs) : self
    end

    # Returns true if the current duration has a negative value
    def negative?
      @millis < 0
    end

    # Multiplies this duration by a scalar factor
    # @param other [int] a multiplier
    # @return a new duration with the scalar times the millisecond value
    def multiply_by(other)
      Duration.new(@millis * other)
    end

    # Divides this duration by a scalar factor
    # @param other [int] a divisor
    # @return a new duration with the scalar divided by the other value
    def divide_by(other)
      Duration.new(@millis / other)
    end

    # Same as multiply_by
    def *(other)
      multiply_by(other)
    end

    # Same as divide_by
    def /(other)
      divide_by(other)
    end

    def to_s
      abs_millis = @millis.abs
      epoch_in_seconds = abs_millis / SECONDS
      hours = epoch_in_seconds / HOURS_IN_SECONDS
      seconds_from_start_of_day = epoch_in_seconds - (HOURS_IN_SECONDS * hours)
      hours_in_day = seconds_from_start_of_day / HOURS_IN_SECONDS
      minutes_in_hour = (seconds_from_start_of_day % HOURS_IN_SECONDS) / 60
      seconds_in_minutes = (seconds_from_start_of_day - (hours_in_day * HOURS_IN_SECONDS) - (minutes_in_hour * 60))
      millis_in_seconds = abs_millis - ((abs_millis / SECONDS).to_i * SECONDS)
      hours = hours == 0 ? '' : "#{hours.to_i}H"
      minutes = minutes_in_hour == 0 ? '' : "#{minutes_in_hour}M"
      if seconds_in_minutes == 0 and millis_in_seconds != 0
        seconds = "0.#{millis_in_seconds}S"
      elsif seconds_in_minutes != 0 and millis_in_seconds == 0
        seconds = "#{seconds_in_minutes}S"
      elsif seconds_in_minutes != 0 and millis_in_seconds != 0
        seconds = "#{seconds_in_minutes}.#{millis_in_seconds}S"
      else
        seconds = ''
      end
      sign = @millis < 0 ? "-" : "";
      "#{sign}PT#{hours}#{minutes}#{seconds}"
    end

    # Returns true if the two durations represent the same millisecond value
    def ==(other)
      @millis = other.to_millis
    end

    private

    SECONDS = 1000
    MINUTES = 60000
    HOURS = 3600000
    DAYS = 86400000
    HOURS_IN_SECONDS = 3600
  end
end