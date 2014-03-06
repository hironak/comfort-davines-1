class Payment::Creditcard < Payment
  attr_accessor :card_number, :exp_month, :exp_year, :cvc, :name

  class WebPayValidator < ActiveModel::Validator
    def validate(record)
      begin
        record.charge_create
      rescue WebPay::CardError => e
        case e.code
        when 'invalid_name'
          record.errors.add :name, e.code.to_sym
        when 'incorrect_expiry'
          record.errors.add :expire, e.code.to_sym
        when 'invalid_expiry_month'
          record.errors.add :exp_month, e.code.to_sym
        when 'invalid_expiry_year'
          record.errors.add :exp_year, e.code.to_sym
        when 'invalid_cvc', 'incorrect_cvc'
          record.errors.add :cvc, e.code.to_sym
        else
          record.errors.add :card_number, e.code.to_sym
        end
      end
    end
  end

  def expire
    "#{self.exp_month} / #{self.exp_year}"
  end

  validates_with WebPayValidator, unless: :webpay_id

  def charge_refund
    begin
      charge = WebPay::Charge.retrieve(self.webpay_id)
      charge.refund(amount: self.changed_attributes[:amount].to_i - self.amount)
    rescue WebPay::WebPayError => e
      raise e
    end
  end

  def charge_create
    begin
      if self.webpay_id
        charge_refund
      else
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
          },
          description: self.order.try(:number)
        )
      end
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
