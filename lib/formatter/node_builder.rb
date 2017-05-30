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
require_relative './offset_node'
require_relative './am_pm_node'
require_relative './twelve_hour_node'

module RhodaTime
  module Formatter
    class NodeBuilder

      NODE_MAP = {
          'a' => AmPmNode,
          'Y' => YearNode,
          'M' => MonthNode,
          'd' => DayNode,
          'H' => HourNode,
          'h' => TwelveHourNode,
          'm' => MinuteNode,
          's' => SecondNode,
          'S' => MillisNode,
          'x' => OffsetNode
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
        active.push(node_class(buf[0]).new(buf)) unless buf.empty?
        top_node
      end

      def self.node_class(field)
        NODE_MAP[field] || ConstantNode
      end
    end
  end
end
