desc "load press release data"
task :load_press_releases => :environment do

  PressRelease.destroy_all

  require "csv"

  CSV.read(Rails.root.join("presets/data/press_releases.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

    attrs = attrs.to_hash

    file_name = attrs.delete('image')
    month = attrs.delete('month')
    file_path = "presets/assets/press_release/image/#{month}/#{file_name}"
    attrs['image'] = File.new(file_path) if File.file?(file_path)

    attrs['corner'] = attrs['corner'].gsub(/NN/, "\n")
    attrs['products'] = attrs['products'].gsub(/NN/, "\n")
    PressRelease.create(attrs)
  end
end
