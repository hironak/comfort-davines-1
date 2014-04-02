class MailmagazineExportController < ApplicationController
  def index
    @consumers = Consumer.confirmed.where(accepted_magazine: true)
  end
end
