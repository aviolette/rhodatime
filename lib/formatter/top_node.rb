require_relative './node'

module RhodaTime
  module Formatter
    class TopNode < Node

      attr_reader :children

      def initialize
        @children = []
      end

      def push(item)
        children << item
      end

      def parse(parse_item)
        @children.each do | node |
          node.parse parse_item
        end
      end

      def print(time)
        @children.inject('') do | acc, node |
          acc << node.print(time)
        end
      end
    end
  end
end
