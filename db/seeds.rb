# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "csv"

Setting.create! tax_percentage: 5

[
  ['ナチュラルテック', :naturaltech],
  ['オーセンティック', :authentic],
  ['オイ オイル',      :oioil],
  ['モアインサイド',   :moreinside]
].each do |name, identify|
  Series.create name: name, identify: identify
end

[
  ['キット',                   :kit],
  ['シャンプー',               'shampoo'],
  ['コンディショナー＆パック', 'conditioner'],
  ['スペシャルケア',           'specialcare'],
  ['オイル',                   'oil'],
  ['スタイリング',             'styling'],
  ['ミルク',                   :milk,  hidden: true],
  ['ジェル',                   :gel,   hidden: true],
  ['ワックス',                 :wax,   hidden: true],
  ['スプレー',                 :spray, hidden: true]
].each do |name, identify, attrs|
  attrs ||= {}
  attrs[:name] = name
  attrs[:identify] = identify
  Category.create(attrs)
end

%w|エイジングケア ダメージケア デリケートヘア オイリー・頭皮ケア 保湿ケア|.each do |name|
  Solution.create name: name
end

Dir.glob("#{Rails.root}/presets/assets/file_storage/images/**/*").each do |file|
  if File.file? file
    name = file.gsub("#{Rails.root}/presets/assets/file_storage/images/", '')
    FileStorage.find_or_initialize_by(name: name).tap do |storage|
      storage.file = File.new(file)
      puts "#{storage.save} #{file}"
    end
  end
end

%w[
naturaltech_e
naturaltech_n
naturaltech_r
naturaltech_d
naturaltech_c
naturaltech_w
authentic_01
authentic_02
authentic_03
authentic_04
oioil
moreinside_01
moreinside_02
moreinside_03
moreinside_04
moreinside_05
moreinside_06
moreinside_07
].each do |identify|
  template = ::Template.find_or_initialize_by(identify: identify)
  template.name = identify
  header_file = template.send :header_file
  template.header =
    if File.exist?(header_file)
      File.read header_file
    else
      ""
    end
  style_file = template.send :style_file
  template.style =
    if File.exist?(style_file)
      File.read style_file
    else
      ""
    end
  template.save validate: false
end

CSV.read(Rails.root.join("presets/data/products.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

  attrs = attrs.to_hash

  files = attrs['image'].to_s.split(/\s/).map do |image|
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

  attrs['category_ids'] = []
  categories = attrs['categories'].to_s.split.each do |identify|
    category = Category.where(identify: identify).first
    puts identify
    attrs['category_ids'] << category.id
  end
  attrs.delete('categories')

  if series = Series.where(identify: attrs['series']).first
    attrs['series_ids'] = [series.id]
  end
  attrs.delete('series')

  attrs["stock"] = 10

  if identify = attrs.delete('page')
    page = Page.find_or_initialize_by(identify: identify)
    page.title = attrs["name"]
    page.render_type =  "html"
    body_file = page.send :body_file
    page.body =
      if File.exist?(body_file)
        File.read body_file
      else
        ""
      end
    style_file = page.send :style_file
    page.style =
      if File.exist?(style_file)
        File.read style_file
      else
        ""
      end
    page.save validate: false
    attrs['page_id'] = page.id
  end

  singleton = attrs.delete('singleton')

  product = Product.create(attrs)

  if singleton == '1'
    product.series.singleton = product
    product.series.save
  end
end

current_salon = nil

CSV.read(Rails.root.join("presets/data/salons.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

  attrs = attrs.to_hash

  grades = %w|member platina premium|
  attrs["grade"] = grades.detect{|l| attrs["grade_#{l}"] == "○" }
  grades.map{|l| "grade_#{l}" }.each{|grade| attrs.delete(grade) }

  if attrs['name']
    current_salon = Salon.create(attrs)
  else
    attrs.each do |k, v|
      current_salon.attributes[k] += v if v
    end
  end
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

Topic.create(
  date: "2014-03-07",
  subject: "ダヴィネスダイレクト　オープン！",
  body: <<BODY
ダヴィネスの公式オンラインショップ、ダヴィネスダイレクトがオープン致しました。
ダヴィネスダイレクトだけの購入特典として選べるサンプルプレゼントをご用意しております。
また、お得な新着情報が載ったニュースレターも一緒にお届け致します。

これからどうぞ、ダヴィネスダイレクトを宜しくお願い致します！
BODY
)

NewsRelease.create(
  date: "2014-03-07",
  title: "ダヴィネスダイレクト　オープン！",
  body: <<BODY
ダヴィネスの公式オンラインショップ、ダヴィネスダイレクトがオープン致しました。
ダヴィネスダイレクトだけの購入特典として選べるサンプルプレゼントをご用意しております。
また、お得な新着情報が載ったニュースレターも一緒にお届け致します。

これからどうぞ、ダヴィネスダイレクトを宜しくお願い致します！
BODY
)

CSV.read(Rails.root.join("presets/data/press_releases.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

  attrs = attrs.to_hash

  file_name = attrs.delete('image')
  month = attrs.delete('month')
  file_path = "presets/assets/press_release/image/#{month}/#{file_name}"
  attrs['image'] = File.new(file_path) if File.file?(file_path)

  attrs['corner'] = attrs['corner'].gsub(/NN/, "\n")
  attrs['products'] = attrs['products'].gsub(/NN/, "\n")
  PressRelease.create(attrs)
end

CSV.read(Rails.root.join("presets/data/ritou.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

  attrs = attrs.to_hash

  puts attrs['postalcode']

  ritou = Ritou.where(postalcode: attrs['postalcode']).first || Ritou.new
  ritou.attributes = attrs
  ritou.save
end
