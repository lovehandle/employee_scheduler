module EmployeeScheduler
  class Interval
    attr_accessor :start_time , :end_time
    
    def initialize(start_time , end_time)
      @start_time = start_time 
      @end_time = end_time
    end
    
    def overlaps?(other_interval)
      (self.start_time > other_interval.start_time && self.start_time < other_interval.end_time) \
      || (self.end_time > other_interval.start_time && self.end_time < other_interval.end_time)  \
      || (other_interval.start_time > self.start_time && other_interval.start_time < self.end_time) \
      || (other_interval.end_time > self.start_time && other_interval.end_time < self.end_time)
    end

    class << self
      # Factory methods for creating intervals from Shift
      def create_interval_from_shift(shift)
        self.new(shift.start_time , shift.end_time )
      end
      
      # Factory methods for creating intervals from  Conflict
      def create_interval_from_conflict(conflict)
        self.new(conflict.start_time , conflict.end_time )
      end
      
      # Helper method
      def overlaps?(interval_one , interval_two)
        interval_one.overlaps?(interval_two)
      end
    end
  end
end
