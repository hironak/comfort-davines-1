class MailmagazineExportController < ApplicationController
  respond_to :csv
  def index
    @consumers = Consumer.confirmed.where(accepted_magazine: true)
  end

  def run
    book = Cuenote::Api::AddressBook.list[0]
    book.import target: mailmagagine_export_index_path(format: :csv)
  end
end
