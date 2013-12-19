class SessionsController < Devise::SessionsController
  before_filter :succeed_cart, only: [:create]

  private

  # succeed cart
  def succeed_cart
    # TODO: ログイン時に、それまでのカートを引き継ぎたいが、それ以前にログイン状態で作成していたカートがあった場合、どうするか？
  end
end
