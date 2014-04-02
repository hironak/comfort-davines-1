class MailmagazineExportController < ApplicationController
  respond_to :csv
  def index
    @consumers = Consumer.confirmed.where(accepted_magazine: true)
  end
end
