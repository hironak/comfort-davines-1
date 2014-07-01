# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_margin do
    product nil
    agency nil
    backmargin_salon 1
    backmargin_agency 1
  end
end
