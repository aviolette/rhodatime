require_relative './node'

module RhodaTime
  module Formatter
    class TwelveHourNode < Node

      def initialize(val)
        @size = val.length
      end

      def numeric_val(time)
        if time.hour == 0
          12
        elsif time.hour > 12
          time.hour - 12
        else
          time.hour
        end
      end

      private

      def modify_with
        :with_hour
      end
    end
  end
end
