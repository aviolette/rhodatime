module RhodaTime
  class ZoneOffset
    attr_reader :offset_seconds, :name

    def initialize(seconds = 0, name = nil)
      @offset_seconds = seconds; @name = name
    end

    OFFSET_FORMATTER = DateTimeFormatter.new("xxx")

    UTC = ZoneOffset.new(0, 'UTC')

    def self.of(id)
      return UTC if id == 'Z'
      return parse(id) if /^[\+|\-]\d{2}:\d{2}/.match(id)
      matched = /^(UTC|GMT|UT)([\+|\-]\d{2}:\d{2})/.match(id)
      return parse(matched[2]) if matched
      # if /^\w{3}$/.match(id)
      #   return SHORT_IDS[id] unless SHORT_IDS[id].nil?
      # else
      #   item = long_ids[id]
      #   return item unless item.nil?
      # end
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
      formatter.parse date_string, ZoneOffset.new(0, date_string)
    end

    def format(formatter = OFFSET_FORMATTER)
      formatter.format self
    end

    def ==(other)
      other.offset_seconds == @offset_seconds
    end

    def to_s ; format ; end

    def with_offset(offset)
      offset
    end

    def with_offset_seconds(offset)
      ZoneOffset.new(offset, @name)
    end

    def with_name(name)
      ZoneOffset.new(@offset_seconds, name)
    end

# Result: [NST:Pacific/Auckland, MST:-07:00, AET:Australia/Sydney, BET:America/Sao_Paulo, PST:America/Los_Angeles, ACT:Australia/Darwin, SST:Pacific/Guadalcanal, VST:Asia/Ho_Chi_Minh, CAT:Africa/Harare, ECT:Europe/Paris, EAT:Africa/Addis_Ababa, IET:America/Indiana/Indianapolis, MIT:Pacific/Apia, NET:Asia/Yerevan]

=begin
    SHORT_IDS = {
        'CTT' => ZoneOffset.of_time(8).with_name('Asia/Shanghai'),
        'ART' => ZoneOffset.of_time(3).with_name('Africa/Cairo'),
        'CNT' => ZoneOffset.of_time(-2, 30).with_name('America/St_Johns'),
        'PRT' => ZoneOffset.of_time(-4).with_name('America/Puerto_Rico'),
        'PNT' => ZoneOffset.of_time(-7).with_name('America/Phoenix'),
        'PLT' => ZoneOffset.of_time(5).with_name('Asia/Karachi'),
        'AST' => ZoneOffset.of_time(-8).with_name('America/Anchorage'),
        'BST' => ZoneOffset.of_time(6).with_name('Asia/Dhaka'),
        'CST' => ZoneOffset.of_time(-5).with_name('America/Chicago'),
        'EST' => ZoneOffset.of_time(-4).with_name('America/New_York'),
        'HST' => ZoneOffset.of_time(-10),
        'JST' => ZoneOffset.of_time(9).with_name('Asia/Tokyo'),
        'IST' => ZoneOffset.of_time(5, 30).with_name('Asia/Kolkata'),
        'AGT' => ZoneOffset.of_time(-3).with_name('America/Argentina/Buenos_Aires'),
    }

    def self.long_ids
      return @long_ids unless @long_ids.nil?
      @long_ids = SHORT_IDS.values.inject({}) do |acc, val|
        acc[val.name] = val
        acc
      end
      @long_ids
    end
=end


  end
end