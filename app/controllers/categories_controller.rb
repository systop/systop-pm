class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permission
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    #byebug
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category.project, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title, :project_id)
    end

    def check_permission
      #byebug
      unless current_user.workgroup == 'Administrators' || Role.where(user: current_user, project: params[:project_id], title: "Manager").exists? || Role.where(user: current_user, project: params[:category][:project_id], title: "Manager").exists?
        if params.has_key? :project_id
          redirect_to Project.find(params[:project_id])
        else
          redirect_to root_path
        end
        flash[:error] = "Access denied. You have not enough rights | #{params}"
      end
    end

end

