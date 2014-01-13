# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.create! tax: 5

%w|NATURALTECH AUTHENTIC OI/OIL comingsoon|.each_with_index do |name, n|
  Series.create name: name, topimage: File.new(Rails.root.join("test/assets/products/image/series0#{n + 1}.jpg"))
end

%w|シャンプー コンディショナー オイル クリーム スカルプケア ミスト|.each do |name|
  Category.create name: name
end

require "csv"

CSV.read(Rails.root.join("test/fixtures/products.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

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

CSV.read(Rails.root.join("test/fixtures/salons.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

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
