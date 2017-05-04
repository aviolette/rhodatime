require_relative './year_node'
require_relative './month_node'
require_relative './day_node'
require_relative './constant_node'
require_relative './top_node'
require_relative './optional_section_node'
require_relative './hour_node'
require_relative './minute_node'
require_relative './second_node'
require_relative './millis_node'

module RhodaTime
  module Formatter
    class NodeBuilder

      NODE_MAP = {
          'Y' => YearNode,
          'M' => MonthNode,
          'd' => DayNode,
          'H' => HourNode,
          'h' => HourNode,
          'm' => MinuteNode,
          's' => SecondNode,
          'S' => MillisNode
      }

      def self.build_nodes(format)
        top_node = TopNode.new
        active = top_node
        prev = nil
        buf = ''
        format.chars.each do |c|
          if !prev.nil? and prev != c and !buf.empty?
            if buf != '[' and buf != ']'
              active.push(node_class(prev).new(buf))
            elsif buf == '['
              item = OptionalSectionNode.new(active)
              active.push(item)
              active = item
            end
            buf = ''
          end
          if c == ']'
            active = active.parent
          else
            prev = c
            buf << c
          end
        end
        if !buf.empty?
          active.push(node_class(buf[0]).new(buf))
        end
        top_node
      end

      def self.node_class(field)
        NODE_MAP[field] || ConstantNode
      end

    end
  end
end
