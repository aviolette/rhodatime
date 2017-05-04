require_relative './node'

module RhodaTime
  module Formatter
    class DayNode < Node
      def initialize(val)
        @size = val.length
      end

      def print(time)
        val = time.day
        if @size == 1
          val
        else
          twopad(val)
        end
      end
    end
  end
end
