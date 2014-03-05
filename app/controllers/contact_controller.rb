class ContactController < ApplicationController
  before_filter :set_contact

  def new
  end

  def create
    @contact.attributes = contact_params
    if @contact.valid?
      ContactMailer.contact(@contact).deliver
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
