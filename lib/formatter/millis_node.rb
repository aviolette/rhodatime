require_relative './node'

module RhodaTime
  module Formatter
    class MillisNode < Node
      def initialize(val)
        @size = val.length
      end

      def numeric_val(time)
        time.millis
      end

      def modify_with
        :with_millis
      end

      def print(time)
        if @size == 1
          numeric_val(time).to_s
        else
          sprintf("%03d", numeric_val(time))
        end
      end
    end
  end
end
