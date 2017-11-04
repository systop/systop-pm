class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  include LogsHelper

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def index
    unless current_user && current_user.workgroup == 'Administrators'
      redirect_to new_user_session_path
      flash[:notice] = "Access to Users denied"
    end
    @users = User.order(:id).page params[:page]
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def show
    @user = User.find(params[:id])
  end

  # POST /resource
  def create
    super
    log_record('users/sign_up', User.last.id)
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  def admin_edit
    @user = User.find(params[:id])
  end

  def admin_update
    @user = User.find(params[:id])
    respond_to do |format|
      #if @user.update(user_params)
      if @user.update(user_params)
        format.html { redirect_to user_show_path(@user.id), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
        #format.json { render :show, status: :ok, location: @user }
      else
        format.html { redirect_to user_admin_edit_path }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    log_record('users/delete', current_user.id)
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  def user_params
    #byebug
    params.require(:user).permit(:name, :phone, :workgroup, :timezone)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :workgroup, :timezone])
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :timezone)
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :phone, :workgroup, :timezone])
  end



  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
