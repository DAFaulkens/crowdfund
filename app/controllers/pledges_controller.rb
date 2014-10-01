class PledgesController < ApplicationController
  before_action :require_signin
  before_action :set_project

  def index
    @pledges = @project.pledges  
  end

  def new
    @pledge = @project.pledges.new
  end

  def create
    @pledge = @project.pledges.new(pledge_params)
    @pledge.user = current_user
    if @pledge.save
      redirect_to project_pledges_path(@project), notice: "Thanks for pledging!"
    else
      render :new
    end
  end


  private

  def set_project
    @project = Project.find_by!(slug: params[:project_id])
  end

  def pledge_params
    params.require(:pledge).permit(:comment, :amount)
  end
end
