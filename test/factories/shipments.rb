# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shipment do
    family_name "MyString"
    family_name_kana "MyString"
    given_name "MyString"
    given_name_kana "MyString"
    postalcode "1111111"
    prefecture_code "13"
    address "MyString"
    building "MyString"
    phone "000-0000-0000"
  end
end
