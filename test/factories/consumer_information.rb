# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :consumer_information, :class => 'Consumer::Information' do
    consumer nil
  end
end
