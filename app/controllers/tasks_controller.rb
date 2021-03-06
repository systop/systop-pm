class TasksController < ApplicationController
  include ApplicationHelper
  include TasksHelper
  before_action :authenticate_user!
  #before_action :check_admin only: [:index]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    #return unless only_admin 'see all tasks'
    #@tasks = Task.all
    @q = Task.ransack(params[:q])
    @tasks = @q.result.page(params[:page])
    # raise '999'
    if params[:q].has_key? :project_id_eq
      render "projects/show", project: @project = Project.find(params[:q][:project_id_eq]), tasks: @tasks, q: @q, id: params[:q][:project_id_eq]
    end
    # Parameters: {"utf8"=>"✓", "q"=>{"title_cont"=>"T", "project_id_eq"=>"4"}, "commit"=>"Search"}
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    #@all_tasks = 
    #if @tasks
     # @q = @tasks.ransack(params[:q])
    #  @tasks = @q.result.page(params[:page])
   # else
      @tasks = @task.subtasks
    # -----------------------------
      @q = @tasks.ransack(params[:q])
      @tasks = @q.result.page(params[:page])
    #end
  end

  # GET /tasks/new
  def new
    #byebug
    return unless allow_creation?

    if Category.where(project: params[:project_id]).size == 0
      redirect_to Project.find(params[:project_id])
      flash[:warning] = "There is no categories in this project. Please " + "<a href=\"#{new_category_path(project_id: params[:project_id])}\" class=\"alert-link\">create new</a> one"
    end

    if params.has_key? :parent_task_id
      @task = Task.new(project_id: params[:project_id], author_id: current_user.id, parent_task_id: params[:parent_task_id])
    else
      @task = Task.new(project_id: params[:project_id], author_id: current_user.id)
    end
    #@task = Task.new(task_params)
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    #byebug
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
      # before #helper save task before changes for UPDATE
      # #@unchanged_task = @task
      # if @task.update(task_params)
      #   after
      #   #make_diff(@unchanged_task, @task)
      # end
      
    respond_to do |format|
      before #helper save task before changes for UPDATE
      if @task.update(task_params)
      # byebug
        after
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    project_for_redirect = @task.project
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_for_redirect }
      flash[:info] = "Task was successfully destroyed" 
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      #byebug
      @task = Task.find(params[:id])

      case params[:action]
      when 'edit'
        admin_author_assignee_manager(@task, 'change this task') 
      when 'update'
        admin_author_assignee_manager(@task, 'change this task') 
      when 'destroy'
        admin_author_manager(@task, 'delete this task') 
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :author_id, :project_id, :assignee_id, :parent_task_id, :sub_task_id, :status, :category_id, :update)
    end

    def admin_author_assignee_manager(task, denied_action)
      #byebug
      unless current_user.workgroup == 'Administrators' || current_user == task.assignee || current_user == task.author || Role.where(user: current_user, project: task.project, title: "Manager").exists?
        redirect_to task
        flash[:error] = "You have not rights to #{denied_action}"
        false
      else
        true
      end
    end

    def admin_author_manager(task, denied_action)
      #byebug
      unless current_user.workgroup == 'Administrators' || current_user == task.author || Role.where(user: current_user, project: task.project, title: "Manager").exists?
        redirect_to task
        flash[:error] = "You have not rights to #{denied_action}"
        false
      else
        true
      end
    end

    def only_admin(denied_action)
      unless current_user.workgroup == 'Administrators'
        redirect_to root_path
        flash[:error] = "You have not rights to #{denied_action}"
        false
      else
        true
      end
    end

    def admin_manager(denied_action)
      unless current_user.workgroup == 'Administrators' || Role.where(user: current_user, project: params[:project_id], title: "Manager").exists?
        #project = Project.find params[:project_id]
        redirect_to Project.find params[:project_id]
        flash[:error] = "You have not rights to #{denied_action}"
        false
      else
        true
      end
    end

    def allow_creation?
      case params
      when -> (p) { [:parent_task_id, :project_id].all? {|s| p.key? s} }
        parent_task = Task.find params[:parent_task_id]
        admin_author_assignee_manager(parent_task, 'create subtask')
        #false
      when -> (p) { [:parent_task_id, :project_id].all? {|s| !p.key? s} }
        only_admin 'create free tasks'
        # false
      else
        admin_manager 'create root tasks'
        # false

      end
    end

end
