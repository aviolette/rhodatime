require_relative './node'

module RhodaTime
  module Formatter
    class ConstantNode < Node
      def initialize(val)
        @size = val.length
        @val = val
      end

      def print(time)
        @val
      end
    end
  end
end
