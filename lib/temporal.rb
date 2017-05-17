module RhodaTime
  module Temporal
    def plus(amount)
      self.class.from_epoch_with_self(to_epoch + amount.to_millis, self)
    end

    def plus_millis(millis)
      self.class.from_epoch_with_self(to_epoch + millis, self)
    end

    def plus_seconds(seconds)
      self.class.from_epoch_with_self(to_epoch + Duration.of_seconds(seconds).to_millis, self)
    end

    def plus_minutes(minutes)
      self.class.from_epoch_with_self(to_epoch + Duration.of_minutes(minutes).to_millis, self)
    end

    def minus_minutes(minutes)
      plus_minutes -minutes
    end

    def plus_hours(hours)
      self.class.from_epoch_with_self(to_epoch + Duration.of_hours(hours).to_millis, self)
    end

    def minus_hours(hours)
      plus_hours -hours
    end

    # Returns a new instance with the number of days added to the current date
    def plus_days(days)
      self.class.from_epoch_with_self(self.to_epoch + Duration.of_days(days).to_millis, self)
    end

    def minus_days(days)
      plus_days -days
    end

    def after?(other)
      to_epoch > other.to_epoch
    end

    def before?(other)
      other.to_epoch > t_epoch
    end
  end
end