# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :solution_item, :class => 'Solution::Item' do
    name ""
    solution nil
  end
end
