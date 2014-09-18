require 'spec_helper'

describe "Viewing an individual project" do
  
  it "shows the projects details" do
    project = Project.create(project_attributes(target_pledge_amount: 8000.00))

    visit project_url(project)

    expect(page).to have_text(project.name)
    expect(page).to have_text(project.description)
    expect(page).to have_text("$8,000.00")
    expect(page).to have_text(project.website)
    expect(page).to have_text(project.pledging_ends_on)
    expect(page).to have_text(project.team_members)
    expect(page).to have_selector("img[src$='#{project.image_file_name}']")
  end

  it "shows the number of days remaining if the pledging end date is in the future" do
    project = Project.create!(project_attributes(pledging_ends_on: 20.days.from_now))

    visit project_url(project)

    expect(page).to have_text(project.pledging_ends_on)
  end

  it "shows 'All Done!' if the pledging end date is in the past" do
    project = Project.create!(project_attributes(pledging_ends_on: 20.days.ago))

    visit project_url(project)

    expect(page).to have_text("All Done!")
  end
end
