require 'spec_helper'

describe "Showing an individual user" do
  
  it "shows the user's profile page" do
    user = User.create!(user_attributes)
    sign_in(user)

    visit user_url(user)
    
    expect(page).to have_text(user.username)
    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end

  it "shows the user's favorites in the sidebar" do
    user = User.create!(user_attributes)

    project = Project.create!(project_attributes)
    user.causes << project

    sign_in(user)
    visit user_url(user)

    within("aside#sidebar") do
      expect(page).to have_text(project.name)
    end
  end

  it "includes the user's name in the page title" do
    user = User.create!(user_attributes)

    sign_in(user)
    visit user_url(user)

    expect(page).to have_title("Crowdfund - #{user.username}")
  end
end
