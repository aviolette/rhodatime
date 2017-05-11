# A clock that takes a specific epoch time and always returns that time
class FakeClock
  attr_reader :now, :offset
  def initialize(val, offset = 0)
    @now = val
    @offset = offset
  end
end
