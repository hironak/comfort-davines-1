require "base64"

class Paperclip::DataUriGenerator < Paperclip::UrlGenerator
  def for(style_name, options)
    # if @attachment.queued_for_write[style_name]
    #   "data:#{@attachment.content_type};base64,#{Base64.encode64(@attachment.queued_for_write[style_name].read)}"
    # else
      super
    # end
  end
end

class Paperclip::ExpandedDataUriAdapter < Paperclip::DataUriAdapter

  REGEXP = /\Aexdata:(?<content_type>[-\w]+\/[-\w\+]+)?;(?<original_filename>[^;]+)?;(?<data>.*)/m

  private

  def extract_target(uri)
    data_uri_parts = uri.match(REGEXP) || []
    StringIO.new(Base64.decode64(data_uri_parts[:data] || '')).tap do |data|
      data.class_eval do
        attr_accessor :content_type, :original_filename
      end
      data.content_type = data_uri_parts[:content_type]
      data.original_filename = data_uri_parts[:original_filename]
    end
  end
end

Paperclip.io_adapters.register Paperclip::ExpandedDataUriAdapter do |target|
  String === target && target =~ Paperclip::ExpandedDataUriAdapter::REGEXP
end
