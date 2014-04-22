module Confirmable
  extend ActiveSupport::Concern

  def confirmable?
    valid?
  end
end
