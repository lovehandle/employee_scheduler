FactoryGirl.define do
  factory :conflict do
    association :employee, :factory => :employee
    start_time "14.00"
    end_time   "15.45"
    date {Date.today}
  end
end
