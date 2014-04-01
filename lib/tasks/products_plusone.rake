desc "products plusone"
task :products_plusone => :environment do
  Product.update_all plusone_id: Product::OiOil.first.id
end
