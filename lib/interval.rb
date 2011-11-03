module EmployeeScheduler
  class Interval < Struct.new(:start_time, :end_time)

    # @api public
    def overlaps?(other)
      includes_time?(other.start_time) || includes_time?(other.end_time)
    end

    # @api public
    def self.overlaps?(interval_one, interval_two)
      interval_one.overlaps?(interval_two)
    end

    private

    # @api private
    def includes_time?(time)
      time >= start_time && time <= end_time
    end

  end
end
