desc "load products data"
task :load_products => :environment do

  require "csv"

  current_salon = nil

  CSV.read(Rails.root.join("presets/data/salons.csv").to_s, headers: :first_row, col_sep: "\t").each do |attrs|

    attrs = attrs.to_hash

    grades = %w|member platina premium|
    attrs["grade"] = grades.detect{|l| attrs["grade_#{l}"] == "○" }
    grades.map{|l| "grade_#{l}" }.each{|grade| attrs.delete(grade) }

    if attrs['name']
      current_salon = Salon.find_or_initialize_by(name: attrs['name'])
    else
      attrs.each do |k, v|
        current_salon.attributes[k] += "\n#{v}" if v
      end
    end
    current_salon.save
  end
end
