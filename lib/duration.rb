require 'time'

module RhodaTime
  class Duration

    SECONDS = 1000
    MINUTES = 60000
    HOURS = 3600000
    DAYS = 86400000

    def self.of_millis(millis)
      self.new(millis)
    end

    def self.of_seconds(seconds)
      self.new(seconds * SECONDS)
    end

    def self.of_minutes(minutes)
      self.new(minutes * MINUTES)
    end

    def self.of_hours(hours)
      self.new(hours * HOURS)
    end

    def self.of_days(days)
      self.new(days * DAYS)
    end

    def plus_minutes(minutes)
      Duration.new(@millis + (minutes * MINUTES))
    end

    def plus_hours(hours)
      Duration.new(@millis + (hours * HOURS))
    end

    def to_millis
      @millis
    end

    def to_s
      epoch_in_seconds = @millis / SECONDS
      hours = epoch_in_seconds / 3600
      seconds_from_start_of_day = epoch_in_seconds - (3600 * hours)
      hours_in_day = seconds_from_start_of_day / 3600
      minutes_in_hour = (seconds_from_start_of_day % 3600) / 60
      seconds_in_minutes = (seconds_from_start_of_day - (hours_in_day * 3600) - (minutes_in_hour * 60))
      millis_in_seconds = @millis - ((@millis / SECONDS).to_i * SECONDS)
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
      "PT#{hours}#{minutes}#{seconds}"
    end

    private

    def initialize(millis)
      @millis = millis
    end
  end
end