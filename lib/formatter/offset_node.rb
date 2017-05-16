require_relative './node'

module RhodaTime
  module Formatter
    class OffsetNode < Node
      def initialize(val)
        @size = val.length
      end

      def parse(item)
        # TODO: this only handles size of 3
        hour = item.remainder[1..2].to_i; minutes = item.remainder[4..5].to_i
        sign = item.remainder[0..0]
        hour = -hour if sign == '-'
        item.date_time = item.date_time.with_offset(ZoneOffset.of_time(hour.to_i, minutes.to_i))
      end

      def print(time)
        seconds = time.offset_seconds
        buf = seconds < 0 ? "-" : "+"
        # TODO: this only handles size of 3
        hours = seconds.abs / (60 * 60)
        seconds = seconds.abs % (60 * 60)
        minutes = seconds / 60
        buf << twopad(hours) << ":" << twopad(minutes)
      end

      private

      def modify_with
        :with_offset
      end
    end
  end
end
