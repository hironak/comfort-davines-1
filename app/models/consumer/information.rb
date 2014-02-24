class Consumer::Information < ActiveRecord::Base
  belongs_to :consumer
  include Informationable
end
