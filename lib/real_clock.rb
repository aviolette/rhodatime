require 'date'
require 'singleton'

module RhodaTime

  # A clock that returns the epoch time
  class RealClock
    include Singleton

    # returns the epoch time in milliseconds
    def now
      DateTime.now.strftime('%Q').to_i
    end
  end
end