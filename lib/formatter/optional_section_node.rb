require_relative './node'

module RhodaTime
  module Formatter
    class OptionalSectionNode < Node
      attr_reader :parent

      def initialize(parent)
        @parent = parent
        @children = []
      end

      def push(node)
        @children << node
      end

      def optional?
        true
      end

      def matches?(item)
        item = item.copy
        @children.all? do | node |
          node.matches?(item)
        end
      end

      def parse(parse_item)
        @children.each do | node |
          return unless node.matches? parse_item.copy
          node.parse(parse_item)
        end
      end

      def print(time)
        return '' unless @children.all? { |item| item.optional? or item.numeric_val(time) != 0 }
        @children.inject('') do | acc, node |
          acc << node.print(time)
        end
      end
    end
  end
end
