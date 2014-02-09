# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :series_item, :class => 'Series::Item' do
    name "MyString"
    series nil
  end
end
