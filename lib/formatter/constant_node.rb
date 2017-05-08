require_relative './node'

module RhodaTime
  module Formatter
    class ConstantNode < Node
      def initialize(val)
        @size = val.length
        @val = val
      end

      def optional? ; true ; end

      def parse(item)
        # validate that the string matches the constant expression
        item.remainder = item.remainder[@size..item.remainder.length]
      end

      def print(time) ; @val ; end
    end
  end
end
