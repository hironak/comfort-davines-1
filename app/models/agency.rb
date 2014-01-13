class Agency < ActiveRecord::Base
  has_one :administrator, as: :contractable
end
