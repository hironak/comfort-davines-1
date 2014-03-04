# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :press_release do
    magazine "MyString"
    corner "MyString"
    products "MyText"
  end
end
