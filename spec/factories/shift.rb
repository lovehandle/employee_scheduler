FactoryGirl.define do
  factory :shift do
    start_time DateTime.new(2011,11,3,14,0)
    end_time   DateTime.new(2011,11,3,15,45)
  end
end
