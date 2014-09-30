require 'spec_helper'

describe "Viewing a list of pledges" do
  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end
  
  it "shows the pledges for a specific project" do
    project1 = Project.create!(project_attributes)
    pledge1 = project1.pledges.create!(pledge_attributes(comment: "Example", user: @user))
    pledge2 = project1.pledges.create!(pledge_attributes(comment: "Let's do this!", user: @user))

    project2 = Project.create!(project_attributes(name: "Save the Something"))
    pledge3 = project2.pledges.create!(pledge_attributes(comment: "Hooray!", user: @user))

    visit project_pledges_url(project1)

    expect(page).to have_text(pledge1.comment)
    expect(page).to have_text(pledge2.comment)
    expect(page).not_to have_text(pledge3.comment)
  end
end
