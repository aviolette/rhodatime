require_relative './node'

module RhodaTime
  module Formatter
    class YearNode < Node
      def initialize(val)
        @size = val.length
      end

      def parse(parse_item)
        md = /^(\d{1,4})/.match(parse_item.remainder)
        parse_item.date_time = parse_item.date_time.with_year(md[0].to_i)
        parse_item.remainder = parse_item.remainder[md[0].length..parse_item.remainder.length]
      end

      def print(time)
        val = time.year
        if @size == 4 || @size == 3
          fourpad(val)
        else
          val = twopad(val)
          if val.length > 2
            val[val.length - 2..val.length]
          else
            val
          end
        end
      end
    end
  end
end
