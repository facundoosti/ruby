FactoryGirl.define do
  
  factory :booking do
    start Time.new(2013 , 01, 01)
    :end.to_s 
    association :resource, factory: :resource, strategy: :built 
    sequence(:user) {|n| "person#{n}@example.com" }
  end
  
  factory :resource do
    name "Resource"
    description "Resource description"
  end

end  