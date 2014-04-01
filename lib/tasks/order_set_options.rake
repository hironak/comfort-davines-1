desc "order set options"
task :order_set_options => :environment do
  Order.listable.each(&:save)
end
