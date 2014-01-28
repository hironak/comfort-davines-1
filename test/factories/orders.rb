# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    address "testtest"

    factory :order_with_items do

      ignore do
        products []
      end

      after(:create) do |order, evaluator|
        evaluator.products.each do |product|
          create(:order_item, order: order, amount: 4, origin_price: 2000, product: product)
        end
      end
    end
  end
end
