require_relative './local_date_time'
require_relative './formatter/node_builder'

module RhodaTime
  class DateTimeFormatter
    attr_reader :format

    def initialize(format)
      @format = format
      @nodes = Formatter::NodeBuilder.build_nodes(@format)
    end

    ## Constants
    ISO_LOCAL_DATE = self.new('YYYY-MM-dd')

    def format(time)
      @nodes.inject('') do |acc, node |
        acc << node.print(time)
      end
    end
  end
end