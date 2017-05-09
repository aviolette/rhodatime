require 'date'
require 'singleton'

module RhodaTime

  # A clock that returns the epoch time
  class Clock
    include Singleton

    # returns the epoch time in milliseconds
    def now
      DateTime.now.strftime('%Q').to_i
    end

    # returns the offset in seconds from UTC
    def offset
      Time.now.utc_offset
    end
  end
end