# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :news_release do
    date "2013-10-18"
    title "MyString"
    body "MyText"
  end
end
