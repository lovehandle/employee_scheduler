FactoryGirl.define do
  factory :conflict do
    association :employee, :factory => :employee
    start_time DateTime.new(2011,11,3,14,00)
    end_time   DateTime.new(2011,11,3,15,45)
  end
end
