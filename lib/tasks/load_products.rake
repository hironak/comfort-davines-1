desc "load products data"
task :load_products => :environment do

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

    page = Page.find_or_initialize_by(title: attrs["name"], render_type: "html", identify: identify)
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
    Product.find_or_initialize_by(name: attrs['name'], sample: attrs['sample']).tap do |product|
      product.attributes = attrs
      product.save
    end
  end
end
