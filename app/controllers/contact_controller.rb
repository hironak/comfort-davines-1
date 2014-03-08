class ContactController < ApplicationController
  before_filter :set_contact

  def new
    add_breadcrumb "お問い合わせ"
  end

  def create
    add_breadcrumb "お問い合わせ"
    @contact.attributes = contact_params
    if @contact.valid?
      if params[:confirm]
        render 'confirm'
      else
        ContactMailer.contact(@contact).deliver
      end
    else
      render 'new'
    end
  end

  private

  def set_contact
    @contact = Contact.new
  end

  def contact_params
    params.require(:contact).permit(:type, :name, :name_kana, :email, :phone, :body)
  end
end
