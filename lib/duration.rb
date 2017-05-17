require 'time'

module RhodaTime
  class Duration

    def self.of_millis(millis)
      self.new(millis)
    end

    def to_millis
      @millis
    end

    private

    def initialize(millis)
      @millis = millis
    end
  end
end