require_relative './local_date_time'
require_relative './formatter/node_builder'

module RhodaTime
  class DateTimeFormatter
    attr_reader :format

    def initialize(format)
      @format = format
      @top_node = Formatter::NodeBuilder.build_nodes(@format)
    end

    ## Constants

    BASIC_ISO_DATE = self.new('YYYYMMdd')
    ISO_LOCAL_DATE = self.new('YYYY-MM-dd')
    ISO_LOCAL_TIME = self.new('HH:mm[:ss[.SSS]]')
    ISO_LOCAL_DATE_TIME = self.new("YYYY-MM-ddTHH:mm[:ss[.SSS]]")
    ISO_OFFSET_DATE_TIME = self.new("YYYY-MM-ddTHH:mm[:ss[.SSS]]xxx")

    def format(time)
      @top_node.print time
    end

    def parse(time_string, date_time = LocalDateTime.of(1, 1, 1, 0, 0))
      item = ParseItem.new(date_time, time_string)
      @top_node.parse item
      item.date_time
    end

    private

    class ParseItem
      attr_accessor :date_time, :remainder

      def initialize(date_time, remainder)
        @date_time = date_time; @remainder = remainder
      end

      def copy
        ParseItem.new(@date_time, @remainder)
      end
    end
  end
end