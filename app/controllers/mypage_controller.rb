class MypageController < ApplicationController
  before_filter :authenticate_consumer!

  def index
    @edit = current_consumer.information
  end

end
