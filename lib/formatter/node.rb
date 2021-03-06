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

      def matches?(parse_item)
        matched = does_match(parse_item)
        if matched
          parse parse_item
        end
        matched
      end

      def parse(parse_item)
        if @size == 2
          parse_item.date_time = parse_item.date_time.send(modify_with, parse_item.remainder[0..2].to_i)
          parse_item.remainder = parse_item.remainder[2..parse_item.remainder.length]
        elsif @size == 3
          parse_item.date_time = parse_item.date_time.send(modify_with, parse_item.remainder[0..3].to_i)
          parse_item.remainder = parse_item.remainder[3..parse_item.remainder.length]
        else
          md = /^(\d{1,2})/.match(parse_item.remainder)
          parse_item.date_time = parse_item.date_time.send(modify_with, md[0].to_i)
          parse_item.remainder = parse_item.remainder[md[0].length..parse_item.remainder.length]
        end
      end

      def numeric_val(time)
        0
      end

      def optional?
        false
      end

      def does_match(parse_item)
        Regexp.new("\\d{#{expected_size}}").match(parse_item.remainder[0..expected_size])
      end

      def expected_size
        @size
      end

      private

      def modify_with
        raise DateTimeException, "Not implemented #{self.inspect}"
      end

      def twopad(item)
        sprintf("%02d", item)
      end

      def fourpad(item)
        sprintf("%04d", item)
      end
    end
  end
end
