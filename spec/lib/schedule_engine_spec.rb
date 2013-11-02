require 'spec_helper'

describe ScheduleEngine do
  describe "#generate_fresh_schedule " do
    let(:shift_start_time_day_1) { DateTime.new(2011,11,1,10) }
    let(:shift_end_time_day_1) { DateTime.new(2011,11,1,20) }
    let(:shift_start_time_day_2) { shift_start_time_day_1 + 1.day  }
    let(:shift_end_time_day_2) { shift_end_time_day_1 + 1.day }
    let(:shift_start_time_day_3) { shift_start_time_day_1 + 2.days  }
    let(:shift_end_time_day_3) { shift_end_time_day_1 + 2.days }
    let(:shift_start_time_day_4) { shift_start_time_day_1 + 3.days  }
    let(:shift_end_time_day_4) { shift_end_time_day_1 + 3.days }
    
    
    it " should generate appropriate schedule filtering out the employees that have conflicts" do
      # Creating test data 
      # There are 5 employes , 4 dates . Each day has a shift from 10AM - 8PM 
      employees = []
      dates = []
      shifts = []

      5.times do |i|
        employees << FactoryGirl.create(:employee)
      end
      
      4.times do |i|
        dates << Date.new(2011,11,i+1)
        shifts << Shift.create(:start_time => DateTime.new(2011,11,i+1,10), :end_time => DateTime.new(2011,11,i+1,20))
      end
      
      # For day 1 all employees except employee[0] should have conflict .  
      [1,2,3,4].each do |i|
        Conflict.create(:start_time => shift_start_time_day_1 + 1.hour , :end_time => shift_end_time_day_1 - 5.hours , :employee_id => employees[i].id) 
      end

      # For day 2 all employees have conflict on that day , but employee[1] conflict's lies outside the shift and employee[3]'s conflict ends at end time of the shift .
      [0,2,4].each do |i|
        Conflict.create(:start_time => shift_start_time_day_2 + 1.hour , :end_time => shift_end_time_day_2 - 1.hour, :employee_id => employees[i].id)
      end      
      Conflict.create(:start_time => shift_end_time_day_2 + 1.hour , :end_time => shift_end_time_day_2 + 2.hours  , :employee_id => employees[1].id)
      Conflict.create(:start_time => shift_end_time_day_2 - 1.hour, :end_time => shift_end_time_day_2, :employee_id => employees[3].id)
      
      # For day 3 all employees have conflict on that day except employee[2]. Also employee[1] has a conflict that lies halfway at the start of  a shift and employee 3 has a conflict that lies halfwas at the end of the shit 
      [0,4].each do |i|
        Conflict.create(:start_time => shift_start_time_day_3 + 1.hour , :end_time => shift_end_time_day_3 - 3.hours, :employee_id => employees[i].id)
      end
      Conflict.create(:start_time => shift_start_time_day_3 - 1.hour, :end_time => shift_start_time_day_3 + 1.hour, :employee_id => employees[1].id)
      Conflict.create(:start_time => shift_end_time_day_3 - 1.hour, :end_time => shift_end_time_day_3 + 1.hour, :employee_id => employees[3].id)
      
      # For day 4 , two employees should belong in the shift . 
      [0,1,2].each do |i|
        Conflict.create(:start_time => shift_start_time_day_4 + 1.hour , :end_time => shift_end_time_day_4 - 3.hours , :employee_id => employees[i].id)
      end
      
      schedule_engine = ScheduleEngine.new(dates.first, dates.last)
      generated_schedule = schedule_engine.generate_fresh_schedule

      #shift[i] should have employee[i]  
      employees.each do |employee|
        shifts.each do |shift|
          break if employees.index(employee)==4
          generated_schedule.employee_schedule[employee].include?(shift).should be (employees.index(employee) == shifts.index(shift))
        end
      end
      
      dates.each do |date|
        shifts.each do |shift|
          date_index = dates.index(date)
          shift_index = shifts.index(shift)
          if (date_index == shift_index)
            generated_schedule.schedule[date][shift].should_not be_blank
            employees.each do |employee|
              generated_schedule.schedule[date][shift].include?(employee).should be (shift_index == employees.index(employee))
            end
          else
            generated_schedule.schedule[date][shift].should be_blank
          end
        end
      end
    end
  end
  
  describe "#add_rule" do
    it " should add rule for filter " do
      schedule_engine = ScheduleEngine.new(Date.today, Date.today+5.days)
      rules = schedule_engine.add_rule(ConflictRule.new)
      rules.size.should == 2
    end
    
    it "should raise error if a non rule object is passed to it " do
      schedule_engine = ScheduleEngine.new(Date.today, Date.today+5.days)
      lambda { schedule_engine.add_rule(Schedule.new) }.should raise_error
    end
  end
end
