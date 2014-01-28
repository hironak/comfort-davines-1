class Payment::Creditcard < Payment
  attr_accessor :amount, :card_number, :exp_month, :exp_year, :cvc, :name

  class WebPayValidator < ActiveModel::Validator
    def validate(record)
      begin
        record.charge_create
      rescue WebPay::CardError => e
        case e.code
        when 'incorrect_number'
          record.errors.add :card_number, e.message
        when 'invalid_name'
          record.errors.add :name, e.message
        when 'invalid_expiry_month'
          record.errors.add :exp_month, e.message
        when 'invalid_expiry_year'
          record.errors.add :exp_year, e.message
        when 'invalid_cvc', 'incorrect_cvc'
          record.errors.add :cvc, e.message
        when 'card_declined'
          record.errors.add :card_number, e.message
        end
      end
    end
  end

  validates_with WebPayValidator, unless: :webpay_id

  def charge_create
    begin
      charge = WebPay::Charge.create(
        capture: false,
        amount: self.amount,
        currency: "jpy",
        card: {
          number: self.card_number,
          exp_month: self.exp_month,
          exp_year: self.exp_year,
          cvc: self.cvc,
          name: self.name
        }
      )
    rescue WebPay::WebPayError => e
      raise e
    else
      self.webpay_id = charge.id
    end
  end

  def charge_capture
    charge.capture
  end

  private

  def charge
    WebPay::Charge.retrieve(self.webpay_id)
  end
end
