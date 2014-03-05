class NewsRelease < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  has_attached_file :image, :styles => { :medium => "190x242>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  scope :available, -> { where("date < ?", Date.tomorrow).order(date: :desc) }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
