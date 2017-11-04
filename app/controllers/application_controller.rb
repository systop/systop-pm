class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
#rescue
  #byebug
  before_action :set_timezone

  def set_timezone
    Time.zone = current_user.timezone if current_user
  end
end
