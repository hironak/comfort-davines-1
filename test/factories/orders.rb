# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do

    salon_prefecture '東京都'
    salon_name 'My Salon'
    salon_not_found true

    shipment { build(:shipment) }
    payment { build(:payment_creditcard) }

    delivery_date { I18n.l 5.days.since.to_date }
    delivery_time '12'

    factory :order_with_items do

      ignore do
        products []
        samples []
      end

      before(:create) do |order, evaluator|
        evaluator.samples.each do |product|
          order.items << build(:order_item, amount: 1, origin_price: 0, product: product)
        end
        evaluator.products.each do |product|
          order.items << build(:order_item, amount: 4, origin_price: 2000, product: product)
        end
      end
    end
  end
end
