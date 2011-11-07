class ScheduleEngine
  require 'scheduler_engine_rule'
  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    @schedule = Schedule.new
    @rules = [ConflictRule.new]  # The order here is important 
  end
  
  def add_rule(rule)
    check_rule_type(rule)
    @rules << rule
  end
  
  def generate_fresh_schedule
    @schedule = Schedule.new
    date = @start_date
    while (date <= @end_date)
      Shift.all_on_date(date).each do |shift|
        @schedule.add_employees_to_shift(employees_for_shift(shift, Employee.all), shift)
      end
      date = date + 1.day
    end  
    @schedule    
  end
  
  private
  
  def employees_for_shift(shift, employees)
    available_employees = []
    @rules.each do |rule|
      check_rule_type(rule)
      employees = rule.filter!(employees, shift, @schedule)
    end
    return employees.slice!(0,shift.num_employees_needed)
  end
  
  def check_rule_type(rule)
    throw "Rule need to implement SchedulerEngineRule" unless rule.is_a?(SchedulerEngineRule) 
  end
end

