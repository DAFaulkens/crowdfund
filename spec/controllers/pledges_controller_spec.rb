require 'spec_helper'

describe PledgesController do
  
  before { @project = Project.create!(project_attributes) }

  context "when not signed in" do
    before { session[:user_id] = nil } 

    it "cannot access index" do
      get :index, project_id: @project
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access new" do
      get :new, project_id: @project
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access index" do
      post :create, project_id: @project
      expect(response).to redirect_to(signin_url)
    end
  end
end
