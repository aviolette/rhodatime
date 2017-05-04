module RhodaTime
  module Formatter
    class Node

      attr_reader :size

      def print(time)
        if @size == 1
          numeric_val(time).to_s
        else
          twopad(numeric_val(time))
        end
      end

      def numeric_val(time)
        0
      end

      def optional?
        false
      end

      private

      def twopad(item)
        sprintf("%02d", item)
      end

      def fourpad(item)
        sprintf("%04d", item)
      end

    end
  end
end
