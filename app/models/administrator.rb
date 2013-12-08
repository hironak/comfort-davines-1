class Administrator < ActiveRecord::Base
  authenticates_with_sorcery!
end
