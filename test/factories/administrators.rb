FactoryGirl.define do
  factory :administrator do
    username "testuser"
    password "password"
    password_confirmation "password"
  end
end
