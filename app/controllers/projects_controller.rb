class ProjectsController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :find_project, except: [:index, :new, :create]

  def index
    @projects = Project.ongoing
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project Successfully Updated!"
    else
      render :edit
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "Project Successfully Created!"
    else
      render :new
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, alert: "Project Successfully Deleted!"
  end


  private 

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :website, :target_pledge_amount, :pledging_ends_on)
  end

end
