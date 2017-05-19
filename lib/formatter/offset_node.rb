require_relative './node'

module RhodaTime
  module Formatter
    class OffsetNode < Node
      def initialize(val)
        @size = val.length
      end

      def parse(item)
        matched = does_match(item)
        raise DateTimeException, "parser does not recognize offset node" unless matched
        # TODO: this only handles size of 3
        hour = matched[2].to_i;
        minutes = matched[3].to_i
        sign = matched[1]
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

      def does_match(parse_item)
        /^([\+|\-])(\d{2}):(\d{2})/.match(parse_item.remainder[0..expected_size])
      end

      def expected_size
        # TODO: only supports xxx format
        6
      end

      private

      def modify_with
        :with_offset
      end
    end
  end
end
