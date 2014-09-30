require 'spec_helper'

describe PassionsController do
  before { @project = Project.create!(project_attributes) } 

  context "when not signed in" do
    
    before { session[:user_id] = nil } 

    it "cannot access create" do
      post :create, project_id: @project
      expect(response).to redirect_to(signin_url)
    end

    it "cannot access destroy" do
      delete :destroy, id: 1, project_id: @project
      expect(response).to redirect_to(signin_url)
    end
  end
end
