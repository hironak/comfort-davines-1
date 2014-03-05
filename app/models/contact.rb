class Contact
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :type, :name, :name_kana, :email, :phone, :body

  validates :type, presence: true
  validates :name, presence: true
  validates :name_kana, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :body, presence: true

  def attributes= attrs
    attrs.each do |k, v|
      self.send "#{k}=", v
    end
  end
end
