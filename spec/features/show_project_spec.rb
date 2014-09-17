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
  end
end
