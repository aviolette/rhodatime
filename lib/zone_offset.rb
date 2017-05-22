module RhodaTime
  class ZoneOffset
    attr_reader :offset_seconds, :name

    def initialize(seconds = 0, name = nil)
      @offset_seconds = seconds; @name = name
    end

    OFFSET_FORMATTER = DateTimeFormatter.new("xxx")

    UTC = ZoneOffset.new(0, 'UTC')

    def self.of(id)
      return parse(id) if /^[\+|\-]\d{2}:\d{2}/.match(id)
      return UTC if %w(Z UTC+ UTC UTC- GMT GMT+ GMT- UT- UT UT+).include? id
      raise DateTimeException, "zone ID is not recognized"
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

    def self.from_seconds(offset_seconds)
      self.new(offset_seconds)
    end

    def self.parse(date_string, formatter = OFFSET_FORMATTER)
      formatter.parse date_string, ZoneOffset.new
    end

    def format(formatter = OFFSET_FORMATTER)
      formatter.format self
    end

    def ==(other)
      other.offset_seconds == @offset_seconds
    end

    def to_s ; format ; end

    def with_offset(offset)
      @offset_seconds = offset
    end
  end
end