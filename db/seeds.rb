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

%w|naturaltech_e naturaltech_n naturaltech_r naturaltech_d naturaltech_c naturaltech_w|.each do |identify|
  header_file = "#{Rails.root}/presets/views/template/#{identify}/header.html"
  header = if File.exist?(header_file)
             File.read header_file
           else
             ""
           end
  style_file = "#{Rails.root}/presets/assets/stylesheets/template/#{identify}.css"
  style = if File.exist?(style_file)
            File.read style_file
          else
            ""
          end


  template = ::Template.new(identify: identify, header: header, style: style)
  template.save validate: false
end

Dir.glob("#{Rails.root}/presets/assets/file_storage/images/**/*").each do |file|
  FileStorage.create(name: file, file: File.new(file)) if File.file? file
end

require "csv"

counter = {}

CSV.read(Rails.root.join("presets/data/products.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

  attrs = attrs.to_hash

  count = counter[attrs['template']] ||= 1

  identify = "#{attrs['template']}_#{count}"

  counter[attrs['template']] += 1

  files = attrs['image'].split(/\s/).map do |image|
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

  if template_identify = attrs.delete('template')
    if template = ::Template.where(identify: template_identify).first
      attrs["template_id"] = template.id
    end
  end

  attrs["stock"] = 10

  body_file = "#{Rails.root}/presets/views/page/#{identify}/body.html"
  body = if File.exist?(body_file)
           File.read body_file
         else
           ""
         end
  style_file = "#{Rails.root}/presets/assets/stylesheets/page/#{identify}.css"
  style = if File.exist?(style_file)
            File.read style_file
          else
            ""
          end

  page = Page.new(title: attrs["name"], render_type: "html", body: body, style: style, identify: identify)
  page.save validate: false

  attrs['page_id'] = page.id
  Product.create(attrs)

  attrs["price"] = 0
  attrs["sample"] = true
  Product.create(attrs)
end

CSV.read(Rails.root.join("presets/data/salons.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

  attrs = attrs.to_hash

  grades = %w|member platina premium|
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
