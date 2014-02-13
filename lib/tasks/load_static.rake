desc "load static page data"
task :load_static => :environment do
  (Template.all + Page.all).each do |record|
    puts record
    record.load_static
    record.save validate: false
  end
end
