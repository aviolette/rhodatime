# A clock that takes a specific epoch time and always returns that time
class FakeClock
  attr_reader :now
  def initialize(val)
    @now = val
  end
end
