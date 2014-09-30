class PassionsController < ApplicationController
  before_action :require_signin
  before_action :set_project

  def create
    @project.passions.create!(user: current_user)
    redirect_to @project
  end

  def destroy
    passion = current_user.passions.find(params[:id])
    passion.destroy
    redirect_to @project
  end


  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
