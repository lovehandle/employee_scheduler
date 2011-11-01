# Attributes of EmployeeShiftAssignment
# 
# employee_id            string
# shift_id               string
#

class EmployeeShiftAssignment < ActiveRecord::Base
  validates_presence_of :employee, :shift
  belongs_to :employee
  belongs_to :shift

end
