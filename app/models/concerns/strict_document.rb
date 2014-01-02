module StrictDocument
  class DocumentValidator < ActiveModel::EachValidator
    include W3CValidators

    def self.set_validator klass
      @@validator = klass
    end

    def validator
      @validator ||= @@validator.new
    end

    def validate_each(record, attribute, value)
      validator.validate_text(value).errors.each do |error|
        record.errors[attribute] << error.message
      end
    end
  end

  class HtmlValidator < DocumentValidator
    set_validator MarkupValidator
  end

  class CssValidator < DocumentValidator
    set_validator CSSValidator
  end
end
