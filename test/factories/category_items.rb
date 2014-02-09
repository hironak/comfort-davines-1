# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category_item, :class => 'Category::Item' do
    name "MyString"
    category nil
  end
end
