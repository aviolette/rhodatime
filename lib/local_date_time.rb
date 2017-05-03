require_relative './local_date'
require_relative './local_time'

module RhodaTime
  class LocalDateTime

    def self.of(year, month, day, hour, minute, second=0, millis=0)
      self.new(LocalDate.of(year, month, day), LocalTime.of(hour, minute, second, millis))
    end

    def self.now(clock = RealClock.instance)
      epoch = clock.now
      self.new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch))
    end

    def year
      @date.year
    end

    def month
      @date.month
    end

    def day
      @date.day
    end

    def hour
      @time.hour
    end

    def minute
      @time.minute
    end

    def second
      @time.second
    end

    def millis
      @time.millis
    end

    private

    def initialize(date, time)
      @date = date
      @time = time
    end
  end
end