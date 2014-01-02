# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :administration_page, :class => 'Administration::Page' do
    body "MyText"
    style "MyText"
  end
end
