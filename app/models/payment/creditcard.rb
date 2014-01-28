class Payment::Creditcard < Payment
  attr_accessor :amount, :card_number, :exp_month, :exp_year, :cvc, :name

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
