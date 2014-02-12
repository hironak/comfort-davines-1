# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_template, :class => 'Product::Template' do
    name "MyString"
    header "MyText"
    list "MyText"
    style "MyText"
  end
end
