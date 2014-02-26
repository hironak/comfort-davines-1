desc "load products data"
task :load_products => :environment do

  require "csv"

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
    moreinside01
    moreinside02
    moreinside03
    moreinside04
    moreinside05
    moreinside06
    moreinside07
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

    Product.find_or_initialize_by(refnum: attrs['refnum']).tap do |product|
      product.photos.each_with_index do |photo, i|
        if attrs["photos_attributes"][i]
          attrs["photos_attributes"][i]["id"] = photo.id
        else
          photo.destroy
        end
      end
      product.attributes = attrs
      product.save
    end
  end
end
