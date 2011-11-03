# Attributes of Conflict
#
# start_time   datetime
# end_time     datetime
# employee_id  integer

require 'interval'

class Conflict < ActiveRecord::Base

  belongs_to :employee

  validates_presence_of :start_time, :end_time, :employee

  # @api public
  def lies_in_shift?(shift)
    self.to_interval.overlaps?(shift.to_interval)
  end

  # @api public
  def to_interval
    EmployeeScheduler::Interval.new(start_time, end_time)
  end

end
