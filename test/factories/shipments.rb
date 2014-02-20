# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :shipment do
    family_name "MyString"
    family_name_kana "MyString"
    given_name "MyString"
    given_name_kana "MyString"
    postalcode "MyString"
    prefecture "MyString"
    address "MyString"
    building "MyString"
    phone "MyString"
  end
end
