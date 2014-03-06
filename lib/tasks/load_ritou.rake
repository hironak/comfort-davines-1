desc "load ritou data"
task :load_ritou => :environment do

  require "csv"

  CSV.read(Rails.root.join("presets/data/ritou.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

    attrs = attrs.to_hash

    puts attrs['postalcode']

    ritou = Ritou.where(postalcode: attrs['postalcode']).first || Ritou.new
    ritou.attributes = attrs
    ritou.save
  end
end
