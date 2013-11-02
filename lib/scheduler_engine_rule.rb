class SchedulerEngineRule
  # Abstract class to represent each rule
  def filter!(employees_available, shift, schedule_so_far) 
    # each filter method would sort/filter the employee_available array based on it's business rule 
    raise "This method needs to be overwritten"
  end
end

class ConflictRule < SchedulerEngineRule
  def filter!(employees_available, shift, schedule_so_far)
    conflict_employees = []
    employees_available.each do |employee|
      conflicts = employee.get_conflicts_on(shift.date)
      if conflicts && conflicts.size > 0
        conflicts.each do |conflict|
           (conflict_employees << employee) and break if conflict.lies_in_shift?(shift)
        end
      end
    end
    employees_available = employees_available - conflict_employees
    employees_available
  end
end
