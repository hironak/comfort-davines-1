desc "order set options"
task :order_set_options => :environment do
  Order.all.each(&:save)
end
