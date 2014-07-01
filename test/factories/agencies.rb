# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :agency do
    name "My Agency"
    backmargin_agency 30
    backmargin_salon 25
    administrator nil
  end
end
