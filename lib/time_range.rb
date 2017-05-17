require 'date'
require 'singleton'

module RhodaTime
  class TimeRange
    attr_reader :from, :to

    def initialize(from, to)
      raise DateTimeException, "'to' has to be after 'from'" unless to.after?(from)
      @from = from; @to = to
    end

    def on_interval(duration, &block)
      current = from
      until current.after?(to) do
        block.call(current)
        current = current.plus(duration)
      end
    end
  end
end