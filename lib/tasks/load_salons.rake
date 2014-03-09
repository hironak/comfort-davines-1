desc "load salons data"
task :load_salons => :environment do

  require "csv"

  current_salon = nil

  CSV.read(Rails.root.join("presets/data/salons.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

    attrs = attrs.to_hash

    puts attrs['name']
    puts attrs['name_kana']

    grades = %w|member platina premium|
    attrs["grade"] = grades.detect{|l| attrs["grade_#{l}"] == "○" }
    grades.map{|l| "grade_#{l}" }.each{|grade| attrs.delete(grade) }

    if attrs['name']
      current_salon = Salon.find_or_initialize_by(name: attrs['name'])
      current_salon.attributes = attrs
    else
      attrs.each do |k, v|
        if v
          value = current_salon.send k
          value = "#{value}\r\n#{v}"
          current_salon.send "#{k}=", value
        end
      end
    end
    current_salon.save
  end
end
