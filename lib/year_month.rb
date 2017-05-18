require 'date'

module RhodaTime
  class YearMonth
    attr_reader :year, :month

    def self.of(year, month)
      new(year, month)
    end

    def leap_year?
      Date.gregorian_leap?(year)
    end

    def last_day_of_month
      if [1, 3, 5, 7, 8, 10, 12].include? @month
        31
      elsif [4, 6, 9, 11].include? @month
        30
      elsif leap_year?
        29
      else
        28
      end
    end

    private

    def initialize(year, month)
      raise DateTimeException, "Month is out of range: #{month}" if month < 1 or month > 12
      @year = year; @month = month
    end
  end
end