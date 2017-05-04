require_relative './node'

module RhodaTime
  module Formatter
    class SecondNode < Node

      def initialize(val)
        @size = val.length
      end

      def numeric_val(time)
        time.second
      end
    end
  end
end
