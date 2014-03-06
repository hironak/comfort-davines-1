class Ritou < ActiveRecord::Base
  def self.include? postalcode
    postalcode.gsub!(/-/, '')
    !!where(postalcode: postalcode).first
  end
end
