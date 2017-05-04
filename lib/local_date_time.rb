require_relative './local_date'
require_relative './local_time'

module RhodaTime
  class LocalDateTime

    def self.of(year, month, day, hour, minute, second=0, millis=0)
      self.new(LocalDate.of(year, month, day), LocalTime.of(hour, minute, second, millis))
    end

    def self.now(clock = Clock.instance)
      epoch = clock.now
      self.new(LocalDate.from_epoch(epoch), LocalTime.from_epoch(epoch))
    end

    def year ; @date.year ; end

    def month ; @date.month ; end

    def day ; @date.day ; end

    def hour ; @time.hour ; end

    def minute ; @time.minute ; end

    def second ; @time.second ; end

    def millis ; @time.millis ; end

    def with_year(year)
      LocalDateTime(@date.with_year(year), @time)
    end

    def with_month(month)
      LocalDateTime(@date.with_month(month), @time)
    end

    def with_day(day)
      LocalDateTime(@date.with_day(day), @time)
    end

    def with_minute(minutes)
      LocalDateTime.new(@date, @time.with_minute(minutes))
    end

    def with_second(seconds)
      LocalDateTime.new(@date, @time.with_second(seconds))
    end

    def with_millis(millis)
      LocalDateTime.new(@date, @time.with_millis(millis))
    end

    def format(formatter = DateTimeFormatter::ISO_LOCAL_DATE_TIME)
      formatter.format self
    end

    def to_s ; format ; end

    private

    def initialize(date, time)
      @date = date
      @time = time
    end
  end
end