class AdminSettingsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_admin_setting, only: [:show, :edit, :update, :destroy]

  # GET /admin_settings
  # GET /admin_settings.json
  def index
    @admin_settings = AdminSetting.all
  end

  # GET /admin_settings/1
  # GET /admin_settings/1.json
  def show
  end

  # GET /admin_settings/new
  def new
    @admin_setting = AdminSetting.new
  end

  # GET /admin_settings/1/edit
  def edit
  end

  # POST /admin_settings
  # POST /admin_settings.json
  def create
    @admin_setting = AdminSetting.new(admin_setting_params)
    #byebug
    @admin_setting.alias = @admin_setting.title.downcase.split(' ').join('_')

    respond_to do |format|
      if @admin_setting.save
        format.html { redirect_to @admin_setting, notice: 'Admin setting was successfully created.' }
        format.json { render :show, status: :created, location: @admin_setting }
      else
        format.html { render :new }
        format.json { render json: @admin_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_settings/1
  # PATCH/PUT /admin_settings/1.json
  def update
    respond_to do |format|
      if @admin_setting.update(admin_setting_params)
        format.html { redirect_to @admin_setting, notice: 'Admin setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_setting }
      else
        format.html { render :edit }
        format.json { render json: @admin_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_settings/1
  # DELETE /admin_settings/1.json
  def destroy
    @admin_setting.destroy
    respond_to do |format|
      format.html { redirect_to admin_settings_url, notice: 'Admin setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_setting
      @admin_setting = AdminSetting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_setting_params
      params.require(:admin_setting).permit(:title, :alias, :value, :description, :for)
    end

    def check_admin
      if current_user.workgroup != 'Administrators'
        #redirect_back fallback_location: 'home#index'
        redirect_to :root
        flash[:notice] = "Access to Settings denied"
      end
    end

end
