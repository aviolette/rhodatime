require_relative './node'

module RhodaTime
  module Formatter
    class OffsetNode < Node
      def initialize(val)
        @size = val.length
      end

      def parse(item)
        # implement
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
    end
  end
end
