require 'spec_helper'

describe "Filtering Projects" do
  
  it "shows past projects" do
    project = Project.create!(project_attributes(pledging_ends_on: 1.month.ago))

    visit projects_url
    click_link 'Past Projects'
    
    expect(current_path).to eq("/projects/past")
    expect(page).to have_text(project.name)
  end

  it "shows recently_added projects" do
    project = Project.create!(project_attributes(created_at: 1.hour.ago))

    visit projects_url
    click_link 'Recently Added'
    
    expect(current_path).to eq("/projects/recently_added")
    expect(page).to have_text(project.name)
  end
end
