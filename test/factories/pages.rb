# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    body "MyText"
    style <<-STYLE
      .validstyle {
        padding: 0px;
      }
    STYLE
  end
end
