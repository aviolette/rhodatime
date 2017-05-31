require 'time'

module RhodaTime
  class Duration

    # add multiply_by and divide_by and * and / operators

    def self.of_millis(millis)
      new(millis)
    end

    def self.of_seconds(seconds)
      new(seconds * SECONDS)
    end

    def self.of_minutes(minutes)
      new(minutes * MINUTES)
    end

    def self.of_hours(hours)
      new(hours * HOURS)
    end

    def self.of_days(days)
      new(days * DAYS)
    end

    #TODO: include temporal / add units

    def plus_minutes(minutes)
      Duration.new(@millis + (minutes * MINUTES))
    end

    def plus_hours(hours)
      Duration.new(@millis + (hours * HOURS))
    end

    def plus_seconds(seconds)
      Duration.new(@millis + (seconds * SECONDS))
    end

    def plus_millis(millis)
      Duration.new(@millis + millis)
    end

    def to_millis
      @millis
    end

    def negated
      Duration.new(-@millis)
    end

    def abs
      negative? ? Duration.of_millis(@millis.abs) : self
    end

    def negative?
      @millis < 0
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

    def ==(other)
      @millis = other.to_millis
    end

    private

    SECONDS = 1000
    MINUTES = 60000
    HOURS = 3600000
    DAYS = 86400000
    HOURS_IN_SECONDS = 3600

    def initialize(millis)
      @millis = millis
    end
  end
end