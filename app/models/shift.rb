# Attributes of Shift
# 
# start_time   datetime
# end_time     datetime
#

class Shift < ActiveRecord::Base
  has_many :employee_shift_assignments
  has_many :employees, :through => :employee_shift_assignments
  
  NUM_EMPLOYEES_NEEDED = 1
  
  validates_presence_of :start_time, :end_time

  scope :all_on_date, lambda { |date|
      #TODO :: Need to handle shifts that can span across dates in future .
      where('date(start_time) = ?', date)
  }
    
  def num_employees_needed
    # We might want to specify the number of employee needed per each shift 
    self[:num_employees_needed] || NUM_EMPLOYEES_NEEDED
  end
  
end
