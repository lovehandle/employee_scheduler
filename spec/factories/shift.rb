FactoryGirl.define do
  factory :shift do
    start_time "14.00"
    end_time   "15.45"
    date {Date.today}
  end
end
