class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_date

  helper_method :set_current_date

  def set_current_date
    @current_date = Date.today
  end
end
