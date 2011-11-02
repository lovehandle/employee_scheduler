require 'spec_helper'

describe EmployeeShiftAssignment do
  it {
    should belong_to :employee
    should belong_to :shift
  }
end
