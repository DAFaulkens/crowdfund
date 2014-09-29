require 'spec_helper'

describe "Deleting a project" do
  before do
    admin = User.create!(user_attributes(admin: true))
    sign_in(admin)
  end
  
  it "destroys the project and shows the listing without the project" do
    project = Project.create!(project_attributes)

    visit project_url(project)
    click_link "Delete"

    expect(current_path).to eq(projects_path)
    expect(page).not_to have_text(project.name)
  end
end
