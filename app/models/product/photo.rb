class Product::Photo < ActiveRecord::Base
  belongs_to :product

  has_attached_file :image,
    styles: {
      medium: "250x380>",
      item: "230x230>",
      thumb: "100x100>",
      mini: "65x65>" },
    url_generator: Paperclip::DataUriGenerator

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
