require 'spec_helper'

describe "Creating a new project" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
    @category1 = Category.create!(name: "Category 1")
    @category2 = Category.create!(name: "Category 2")
    @category3 = Category.create!(name: "Category 3")
  end
  
  it "creates the project and shows the new project's details" do
    visit projects_url

    click_link 'Add New Project'
    expect(current_path).to eq(new_project_path)

    fill_in 'Name', with: "Project Name"
    fill_in 'Description', with: "Project Description"
    fill_in 'Website', with: "http://www.projectname.org"
    fill_in 'Target pledge amount', with: "80000"
    select (Time.now.year - 1).to_s, from: "project_pledging_ends_on_1i"
    fill_in 'Team members', with: "The Team Members"
    fill_in 'Image file name', with: "project.png"
    check @category1.name
    check @category2.name

    click_button 'Create Project'

    expect(current_path).to eq(project_path(Project.last))
    expect(page).to have_text("Project Name")
    expect(page).to have_text(@category1.name)
    expect(page).to have_text(@category2.name)
    expect(page).not_to have_text(@category3.name)
  end

  it "does not save the project if it's invalid" do
    visit new_project_url

    expect {
      click_button 'Create Project'
    }.not_to change(Project, :count)

    expect(page).to have_text('error')
  end
end
