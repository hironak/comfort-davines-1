# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :template do
    name "MyString"
    header "MyText"
    list "MyText"
    style "MyText"
  end
end
