require_relative './year_node'
require_relative './month_node'
require_relative './day_node'
require_relative './constant_node'

module RhodaTime
  module Formatter
    class NodeBuilder

      @@node_map = {
          'Y' => YearNode,
          'M' => MonthNode,
          'd' => DayNode
      }

      def self.build_nodes(format)
        nodes = []
        prev = nil
        buf = ''
        format.chars.each do |c|
          if !prev.nil? and prev != c and !buf.empty?
            nodes << node_class(prev).new(buf)
            buf = ''
          end
          prev = c
          buf << c
        end
        if !buf.empty?
          nodes << node_class(buf[0]).new(buf)
        end
        nodes
      end

      def self.node_class(field)
        @@node_map[field] || ConstantNode
      end
    end
  end
end
