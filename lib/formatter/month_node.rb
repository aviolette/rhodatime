require_relative './node'

module RhodaTime
  module Formatter
    class MonthNode < Node

      MONTHS = {
          1 => 'January',
          2 => 'February',
          3 => 'March',
          4 => 'April',
          5 => 'May',
          6 => 'June',
          7 => 'July',
          8 => 'August',
          9 => 'September',
          10 => 'October',
          11 => 'November',
          12 => 'December'
      }

      def initialize(val)
        @size = val.length
      end

      def numeric_val(time)
        time.month
      end

      def print(time)
        val = numeric_val(time)
        if @size == 5
          MONTHS[val][0]
        elsif @size == 4
          MONTHS[val]
        elsif @size == 3
          MONTHS[val][0..2]
        elsif @size == 2
          twopad(val)
        else
          val.to_s
        end
      end
    end
  end
end
