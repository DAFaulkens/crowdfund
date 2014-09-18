require 'spec_helper' 

describe "Viewing the projects list" do
  
  it "shows the projects" do
    project = Project.create!(project_attributes)
    project1 = Project.create!(name: "Project A", description: "A description for a start up project", target_pledge_amount: 100.00, pledging_ends_on: 2.days.from_now, website: "http://projecta.com", team_members: "The Team", image_file_name: "project.png")
    project2 = Project.create!(name: "Project B", description: "A description for another start up project", target_pledge_amount: 400.00, pledging_ends_on: 22.days.from_now, website: "http://projectb.com", team_members: "Another Team", image_file_name: "project.png")
    project3 = Project.create!(name: "Project C", description: "A description for a third start up project", target_pledge_amount: 800.00, pledging_ends_on: 40.days.from_now, website: "http://projectc.com", team_members: "The C Team", image_file_name: "project.png")

    visit projects_url

    expect(page).to have_text("4 Projects")
    expect(page).to have_text(project.name)
    expect(page).to have_text(project1.name)
    expect(page).to have_text(project2.name)
    expect(page).to have_text(project3.name)

    expect(page).to have_text(project1.description)
    expect(page).to have_text("$100")
    expect(page).to have_text(project1.pledging_ends_on)
    expect(page).to have_text(project1.website)
    expect(page).to have_selector("img[src$='#{project.image_file_name}']")
  end

  it "does not show a project that is no longer accepting pledges" do
    project = Project.create!(project_attributes(pledging_ends_on: 20.days.ago))

    visit projects_url

    expect(page).not_to have_text(project.name)
  end
end
