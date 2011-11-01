# Attributes of Shift
# 
# start_time   string
# end_time     string
# date         date
#

class Shift < ActiveRecord::Base
  has_many :employee_shift_assignments
  has_many :employees, :through => :employee_shift_assignments
  
  NUM_EMPLOYEES_NEEDED = 1
  
  validates_presence_of :start_time, :end_time, :date

  scope :all_shift_on, lambda { |date|
      where('date = ?', date)
  }

  def start_time_numeric
    start_time.gsub(":", ".").to_f
  end

  def end_time_numeric
    end_time.gsub(":", ".").to_f
  end 
    
  def num_employees_needed
    # We might want to specify the number of employee needed per each shift 
    self[:num_employees_needed] || Shift.NUM_EMPLOYEES_NEEDED
  end
  
end
