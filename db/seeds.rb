# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.create! tax_percentage: 5

%w|ナチュラルテック オーセンティック OI/OIL モアインサイド|.each do |name|
  Series.create name: name
end

%w|キット シャンプー コンディショナー＆パック スペシャルケア オイル スタイリング|.each do |name|
  Category.create name: name
end

%w|エイジングケア ダメージケア デリケートヘア オイリー・頭皮ケア 保湿ケア|.each do |name|
  Solution.create name: name
end

require "csv"

CSV.read(Rails.root.join("presets/data/products.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

  attrs = attrs.to_hash

  files = attrs['image'].split(',').map do |image|
    %w|jpg png|.map { |ext| Rails.root.join("presets/assets/products/image/#{image}.#{ext}") }
  end.flatten

  files = files.find_all { |f| File.exist?(f) }

  attrs.delete 'image'
  attrs["photos_attributes"] = []
  files.each do |file|
   attrs["photos_attributes"] << {
      "image" => File.new(file)
    }
  end

  attrs["stock"] = 10

  Product.create(attrs)

  attrs["price"] = 0
  attrs["sample"] = true
  Product.create(attrs)
end

CSV.read(Rails.root.join("presets/data/salons.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

  attrs = attrs.to_hash

  grades = %w|member platina premium trial|
  attrs["grade"] = grades.detect{|l| attrs["grade_#{l}"] == "○" }
  grades.map{|l| "grade_#{l}" }.each{|grade| attrs.delete(grade) }

  Salon.create(attrs)
end

# Development Administrator
if (Rails.env.development? || Rails.env.staging?) && Administrator.count == 0
  FactoryGirl.find_definitions if require 'factory_girl'
  extend FactoryGirl::Syntax::Methods

  create :administrator, username: "testuser"

  agency = create :agency
  create :administrator,
    username: "testagency",
    contractable: agency

  salon = create :salon, agencies: [agency]
  create :administrator,
    username: "testsalon",
    contractable: salon
end
