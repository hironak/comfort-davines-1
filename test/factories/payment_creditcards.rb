# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_creditcard, :class => 'Payment::Creditcard' do
    card_number "4242424242424242"
    exp_month   1.years.since.month
    exp_year    1.years.since.year
    cvc         "111"
    name        "Test User"
  end
end
