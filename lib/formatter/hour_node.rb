require_relative './node'

module RhodaTime
  module Formatter
    class HourNode < Node

      def initialize(val)
        @size = val.length
      end

      def numeric_val(time)
        time.hour
      end

      private

      def modify_with
        :with_hour
      end

    end
  end
end
