desc "load static page data"
task :load_static => :environment do
  (Template.all + Page.all).each do |record|
    puts record
    record.load_static
    record.save validate: false
  end
  Dir.glob("#{Rails.root}/presets/assets/file_storage/images/**/*").each do |file|
    if File.file? file
      name = file.gsub("#{Rails.root}/presets/assets/file_storage/images/", '')
      FileStorage.find_or_initialize_by(name: name).tap do |storage|
        storage.file = File.new(file)
        storage.save
      end
    end
  end
end
