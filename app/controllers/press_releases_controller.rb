class PressReleasesController < ApplicationController
  def index
    @press_releases = PressRelease.rank(:row_order).page(params[:page]).per(5)
  end
end
