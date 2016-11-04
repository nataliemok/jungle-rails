class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

# Session logic
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  # helper_method :current_user
  # bill said move it up  there.
  # def authorize
  #   redirect_to '/login' unless current_user
  # end

  def is_admin?
    # if user is not an admin, send annoying gif
    # redirect to home
  end

end
