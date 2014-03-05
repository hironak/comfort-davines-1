class PressReleasesController < ApplicationController
  def index
    @press_releases = PressRelease.page(params[:page]).per(5).order(created_at: :desc)
  end
end
