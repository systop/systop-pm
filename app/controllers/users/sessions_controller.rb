class Users::SessionsController < Devise::SessionsController
  include LogsHelper
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  #def new
    #buebug
  #  super
  #end

  # POST /resource/sign_in
  def create
    super
    log_record('users/login', current_user.id)
  end

  # DELETE /resource/sign_out
  def destroy
    log_record('users/logout', current_user.id)
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
