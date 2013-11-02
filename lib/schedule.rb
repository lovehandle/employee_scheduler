class Schedule
  # a wrapper for representing the schedule hash
  attr_accessor :schedule, :employee_schedule 
  
  def initialize
    @schedule = {}
    @employee_schedule = {}
  end
  
  def add_date_to_schedule(date)
    @schedule[date] = {} unless @schedule[date] 
  end
  
  def add_shift_for_date(shift, date)
    add_date_to_schedule(date) unless @schedule[date] 
    @schedule[date][shift] = [] unless @schedule[date][shift]
  end
  
  def add_employees_to_shift(employees, shift)
    add_shift_for_date(shift, shift.date) unless ( @schedule[shift.date][shift] rescue nil )
    employees.each do |employee|
      @schedule[shift.date][shift] << employee
      @employee_schedule[employee] = [] unless @employee_schedule[employee]
      @employee_schedule[employee] << shift
    end
  end
  
  def get_employees_for_shift(shift)
    @schedule[shift.date][shift] rescue nil
  end
  
  def get_employee_shifts(employee)
    @employee_schedule[employee]
  end
    
end
