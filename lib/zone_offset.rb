module RhodaTime
  class ZoneOffset
    attr_reader :offset_seconds

    OFFSET_FORMATTER = DateTimeFormatter.new("xxx")

    def self.of(id)
      # implement
    end

    def self.of_time(hours, minutes = 0, seconds = 0)
      raise DateTimeException, "Hours must be between -18 and 18" if hours < -18 or hours > 18
      raise DateTimeException, "Minutes must be between 0 and 59" if minutes < 0 or minutes > 59
      raise DateTimeException, "Seconds must be between 0 and 59" if seconds < 0 or seconds > 59
      if hours < 0
        minutes = -(minutes.abs)
      end
      self.new((hours * 60 * 60) + (minutes * 60) + seconds)
    end

    def self.parse(date_string, formatter = OFFSET_FORMATTER)
      formatter.parse date_string, ZoneOffset.new
    end

    def format(formatter = OFFSET_FORMATTER)
      formatter.format self
    end

    private

    def initialize(seconds = 0)
      @offset_seconds = seconds
    end
  end
end