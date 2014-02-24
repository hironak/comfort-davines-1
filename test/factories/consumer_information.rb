# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :consumer_information, :class => 'Consumer::Information' do
    family_name "Test"
    given_name "Test"
    family_name_kana "Test"
    given_name_kana "Test"
    postalcode "Test"
    prefecture_code "1"
    address "Test"
    building "Test"
    phone "Test"
  end
end
