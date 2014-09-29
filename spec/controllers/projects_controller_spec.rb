require 'spec_helper'

describe ProjectsController do
  
  before { @project = Project.create!(project_attributes) }

  context "when not signed in as an admin user" do
    before do
      non_admin = User.create!(user_attributes(admin: false))
      session[:user_id] = non_admin
    end

    it "cannot access new" do
      get :new
      expect(response).to redirect_to(root_url)
    end

    it "cannot access new" do
      post :create
      expect(response).to redirect_to(root_url)
    end

    it "cannot access new" do
      get :edit, id: @project
      expect(response).to redirect_to(root_url)
    end

    it "cannot access new" do
      patch :update, id: @project
      expect(response).to redirect_to(root_url)
    end
    
    it "cannot access new" do
      delete :destroy, id: @project
      expect(response).to redirect_to(root_url)
    end
  end

end
