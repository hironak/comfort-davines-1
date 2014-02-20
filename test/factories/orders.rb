# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do

    before(:create) {|order| order.shipment = build(:shipment) }

    salon_prefecture '東京都'
    salon_name 'My Salon'
    salon_not_found true

    factory :order_with_items do

      ignore do
        products []
      end

      before(:create) do |order, evaluator|
        evaluator.products.each do |product|
          order.items << build(:order_item, amount: 4, origin_price: 2000, product: product)
        end
      end
    end
  end
end
