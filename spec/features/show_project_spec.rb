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

  it "shows the amount outstanding if the project is not funded" do
    project = Project.create(project_attributes(target_pledge_amount: 50.00))
    project.pledges.create(pledge_attributes(amount: 25.00))

    visit project_url(project)

    expect(page).to have_link("Only $25.00 left!")
    expect(page).to have_link("Pledge!")
    expect(page).not_to have_text("Funded!")
  end

  it "shows 'Funded' without a pledge link if the project is funded" do
    project = Project.create(project_attributes(target_pledge_amount: 25.00))
    project.pledges.create(pledge_attributes(amount: 25.00))

    visit project_url(project)
    expect(page).to have_text("Funded!")
    expect(page).not_to have_link("Pledge!")
  end

  it "shows the project's supporters and categories in the sidebar" do
    project = Project.create!(project_attributes)

    user = User.create!(user_attributes)
    project.supporters << user

    category = Category.create!(name: "International")
    project.categories << category

    visit project_url(project)

    within("aside#sidebar") do
      expect(page).to have_text(user.name)
      expect(page).to have_text(category.name)
    end
  end

  it "includes the project's title in the page title" do
    project = Project.create!(project_attributes)

    visit project_url(project)

    expect(page).to have_title("Crowdfund - #{project.name}")
  end

  it "has an SEO-friendly URL" do
    project = Project.create!(project_attributes(name: "Save Woodstock"))

    visit project_url(project)

    expect(current_path).to eq("/projects/save-woodstock")
  end
end
