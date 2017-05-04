require_relative './node'

module RhodaTime
  module Formatter
    class MinuteNode < Node

      def initialize(val)
        @size = val.length
      end

      def numeric_val(time)
        time.minute
      end
    end
  end
end
