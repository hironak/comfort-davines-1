class Consumers::ConfirmationsController < Devise::ConfirmationsController
  before_filter :set_breadcrumb

  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      render 'complete'
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
    end
  end

  private

  def set_breadcrumb
    add_breadcrumb "マイページログイン"
  end
end
