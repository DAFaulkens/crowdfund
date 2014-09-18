require 'spec_helper'

describe "Creating a new project" do
  
  it "creates the project and shows the new project's details" do
    visit projects_url

    click_link 'Add New Project'
    expect(current_path).to eq(new_project_path)

    fill_in 'Name', with: "Project Name"
    fill_in 'Description', with: "Project Description"
    fill_in 'Website', with: "www.projectname.org"
    fill_in 'Target pledge amount', with: "80000"
    select (Time.now.year - 1).to_s, from: "project_pledging_ends_on_1i"

    click_button 'Create Project'

    expect(current_path).to eq(project_path(Project.last))
    expect(page).to have_text("Project Name")
  end
end
