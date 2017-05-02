require 'time'
module RhodaTime
  class LocalDate
    attr_reader :year, :month, :day

    def self.of(year, month, day)
      self.new(year, month, day)
    end

    def self.now(clock = RealClock.instance)
      # TODO: do this natively
      time = Time.at(clock.now / 1000).getlocal(0)
      self.new(time.year, time.month, time.day)
    end

    private

    def initialize(year, month, day)
      @year = year; @month = month; @day = day
    end
  end
end