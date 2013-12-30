# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development? && Administrator.count == 0
  Administrator.create username: "testuser", password: "password", password_confirmation: "password"
end

%w|シャンプー コンディショナー|.each do |name|
  (1..5).each do |n|
    Product.create name: "#{name}#{n}", stock: 10
    Product.create name: "#{name}#{n} サンプル", stock: 10, sample: true
  end
end
