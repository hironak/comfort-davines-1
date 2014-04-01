desc "products plusone"
task :products_plusone => :environment do
  Product.update_all :plusone_id, OiOil.first.id
end
