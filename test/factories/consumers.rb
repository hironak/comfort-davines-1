FactoryGirl.define do
  factory :consumer, :class => 'Consumer' do
    sequence(:email) {|n| "test#{n}@test.com" }

    password 'password!!'
    password_confirmation 'password!!'

    information { create(:consumer_information) }
  end
end
