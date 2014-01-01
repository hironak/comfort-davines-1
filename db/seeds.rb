# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if (Rails.env.development? || Rails.env.staging?) && Administrator.count == 0
  Administrator.create username: "testuser", password: "password", password_confirmation: "password"
end

%w|NATURALTECH AUTHENTIC OI/OIL comingsoon|.each_with_index do |name, n|
  Series.create name: name, topimage: File.new(Rails.root.join("test/assets/products/image/series0#{n + 1}.jpg"))
end

%w|シャンプー コンディショナー オイル クリーム スカルプケア ミスト|.each do |name|
  Category.create name: name
end

require "csv"

CSV.read(Rails.root.join("test/fixtures/products.csv").to_s, headers: :first_row).each do |attrs|

  attrs = attrs.to_hash

  files = %w|jpg png|.map { |ext| Rails.root.join("test/assets/products/image/#{attrs['image']}.#{ext}") }

  file = files.find { |f| File.exist?(f) }

  attrs["image"] = File.new(file)
  attrs["stock"] = 10

  Product.create(attrs)

  attrs["price"] = 0
  attrs["sample"] = true
  Product.create(attrs)
end
