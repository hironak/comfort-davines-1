desc "load recommendations data"
task :load_recommendations => :environment do

  require "csv"

  CSV.read(Rails.root.join("presets/data/recommendations.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

    puts attrs

    product = Product.where(name: attrs['name']).first
    recommend = Product.where(name: attrs['recommend']).first

    if product && recommend
      product.recommendation_ids ||= []
      product.recommendation_ids << recommend.id

      product.save
    end
  end
end
