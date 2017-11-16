class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    if current_user.workgroup == 'Administrators'
      @projects = Project.all
    elsif ['Users','Project Managers'].include? current_user.workgroup
      #role = Role.where(user: current_user).ids
      @projects = Project.find Role.where(user: current_user).pluck :project_id
    else
      @projects = Project.where(id: 0)
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    #@tasks = Task.where(project_id: @project.id)
    @tasks = Task.where(project_id: @project.id).order('id DESC').page(params[:page])
  end

  # GET /projects/new
  def new
    check_permission
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    check_permission
  end

  # POST /projects
  # POST /projects.json
  def create
    check_permission
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        link_to_author
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def link_to_author
    role = Role.new 
    role.title = 'Manager'
    role.project = @project
    role.user = current_user
    role.save!
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      #byebug
      #@project = Project.find(params[:id])
      if current_user.workgroup == 'Administrators'
        @project = Project.find(params[:id])
      elsif Role.where(user: current_user, project: params[:id]).exists?
        #role = Role.where(user: current_user).ids
        @project = Project.find(params[:id])
      else
        #redirect_to :root
        #format.html { redirect_to root_path, notice: 'Access Denied' }
        redirect_to root_path, notice: 'Access Denied'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :description)
    end

    def check_permission
      unless ['Administrators','Project Managers'].include? current_user.workgroup
        #redirect_to root_path, error: 'Access Denied'
        redirect_to Project.find(params[:id])
      flash[:error] = "Access denied. You have not enough rights"
      end
    end
      #end
    #end
end
