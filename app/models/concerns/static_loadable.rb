require "digest/sha1"

module StaticLoadable
  extend ActiveSupport::Concern

  module ClassMethods
    def attr_static attr, ext='html'
      @@attr_statics ||= {}
      @@attr_statics[self] ||= []
      @@attr_statics[self] << attr
      class_eval <<-KLASS
        if Rails.env.development?
          def #{attr}
            if File.exists? #{attr}_file
              File.read #{attr}_file
            else
              attributes["#{attr}"]
            end
          end
        end

        private

        def #{attr}_file
          @#{attr}_file ||= "\#{Rails.root}/presets/loadable/#{self.name.downcase}/\#{self.identify}/#{attr}.#{ext}"
        end
      KLASS
    end

    def attr_statics
      @@attr_statics[self]
    end

    def cache_key
      Digest::SHA1.hexdigest("latest updated at:#{latest_update}")
    end

    def latest
      self.order(updated_at: :desc).first
    end

    def latest_update
      latest.try :updated_at || "pages never created."
    end

    if Rails.env.development?
      def latest_update
        DateTime.now
      end
    end
  end

  def load_static
    self.class.attr_statics.each do |attr|
      if File.exists? send("#{attr}_file")
        data = File.read send("#{attr}_file")
        self.send "#{attr}=", data
      end
    end
  end
end
