# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "MyString"
    detail "Detail"
    small_detail "Small Detail"
    serieses { [create(:series)] }
    categories { [create(:category)] }
    price 1000
    stock 100
  end
end
