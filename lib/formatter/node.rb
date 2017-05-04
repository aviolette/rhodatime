

module RhodaTime
  module Formatter
    class Node
      attr_reader :size

      def print(val)
        ""
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
