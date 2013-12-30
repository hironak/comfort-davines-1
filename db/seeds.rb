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

%w|NATURALTECH AUTHENTIC OI/OIL|.each do |name|
  Series.create name: name
end

%w|シャンプー コンディショナー オイル クリーム スカルプケア ミスト|.each do |name|
  Category.create name: name
end

Series.all.each do |series|
  Category.all.each do |category|
    Product.create name: "#{series.name} #{category.name}", stock: 10, series_id: series.id, category_id: category.id
    Product.create name: "#{series.name} #{category.name} (サンプル)", stock: 10, series_id: series.id, category_id: category.id, sample: true
  end
end
