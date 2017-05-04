require_relative './node'

module RhodaTime
  module Formatter
    class YearNode < Node
      def initialize(val)
        @size = val.length
      end

      def print(time)
        val = time.year
        if @size == 4 || @size == 3
          fourpad(val)
        else
          val = twopad(val)
          if val.length > 2
            val[val.length - 2..val.length]
          else
            val
          end
        end
      end
    end
  end
end
