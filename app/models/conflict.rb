# Attributes of Conflict
# 
# start_time   string
# end_time     string
# date         date
# employee_id  integer

class Conflict < ActiveRecord::Base
  validates_presence_of :start_time, :end_time, :date, :employee
  belongs_to :employee
  
  def start_time_numeric
    start_time.gsub(":", ".").to_f
  end
  
  def end_time_numeric
    end_time.gsub(":", ".").to_f
  end  
  
  def lies_in_shift(shift)
    if shift.date == self.date
      return time_lies_in_duration(self.start_time_numeric, shift) || time_lies_in_duration(self.end_time_numeric, shift)
    else
      return false
    end
  end
  
  private
  def time_lies_in_duration(time, shift)
    (time.to_f >= shift.start_time_numeric && time.to_f <= shift.end_time_numeric) ? true : false
  end
end
