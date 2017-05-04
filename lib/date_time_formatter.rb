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

    ISO_LOCAL_DATE = self.new('YYYY-MM-dd')
    ISO_LOCAL_TIME = self.new('HH:mm[:ss[.SSS]]')

    def format(time)
      @top_node.print time
    end
  end
end