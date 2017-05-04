require_relative './node'

module RhodaTime
  module Formatter
    class DayNode < Node

      def initialize(val)
        @size = val.length
      end

      def numeric_val(time)
        time.day
      end
    end
  end
end
