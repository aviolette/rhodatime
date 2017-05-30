require_relative './node'

module RhodaTime
  module Formatter
    class AmPmNode < Node

      def initialize(val)
        @size = 1
      end

      def print(time)
        time.hour >= 12 ? "pm" : "am";
      end
    end
  end
end
