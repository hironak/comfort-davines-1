class ContactMailer < ActionMailer::Base
  default from: "contact@davines.co.jp"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.contact.subject
  #
  def contact contact
    @contact = contact
    mail subject: "Davines お問い合わせメール", to: "customer@comfortjapan.jp"
  end
end
