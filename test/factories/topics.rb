# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    date "2014-03-04"
    subject "MyString"
    body "MyBody"
  end
end
