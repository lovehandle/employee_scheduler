# Attributes of Conflict
# 
# start_time   datetime
# end_time     datetime
# employee_id  integer

class Conflict < ActiveRecord::Base
  require 'interval'
  validates_presence_of :start_time, :end_time, :employee
  belongs_to :employee
  
  def lies_in_shift?(shift)
    EmployeeScheduler::Interval.create_interval_from_conflict(self).overlaps?(EmployeeScheduler::Interval.create_interval_from_shift(shift))
  end
  
end
