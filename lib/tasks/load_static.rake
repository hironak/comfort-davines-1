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
        puts "#{storage.save} #{file}"
        puts storage.file_content_type
        unless storage.valid?
          storage.errors.full_messages.each do |message|
            puts message
          end
        end
      end
    end
  end
end
