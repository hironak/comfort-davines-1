# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_photo, :class => 'Product::Photo' do
    image_file_name "MyString"
    image_content_type "MyString"
    image_file_size 1
    image_updated_at "2014-02-09 13:05:48"
  end
end
