# Attributes of EmployeeShiftAssignment
#
# employee_id            string
# shift_id               string
#

class EmployeeShiftAssignment < ActiveRecord::Base

  belongs_to :employee
  belongs_to :shift

  validates_presence_of :employee, :shift

end
