class NewsRelease < ActiveRecord::Base
  scope :available, -> { where("date < ?", Date.tomorrow).order(date: :desc) }
end
