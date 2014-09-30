require 'spec_helper'

describe "Creating a new pledge" do
  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end
  
  it "saves the pledge if it's valid" do
    project = Project.create!(project_attributes)

    visit project_url(project)

    click_link 'Pledge!'

    expect(current_path).to eq(new_project_pledge_path(project))

    select '100', from: "pledge_amount"
    fill_in 'Comment', with: "Hell yes!"

    click_button 'Pledge!'

    expect(current_path).to eq(project_pledges_path(project))
    expect(page).to have_text("Thanks for pledging!")
    expect(page).to have_text(@user.name)
    expect(page).to have_text("$100")
  end

  it "does not save the pledge if it's invalid" do
    project = Project.create!(project_attributes)
    visit new_project_pledge_path(project)

    expect {
      click_button 'Pledge!'
    }.not_to change(Pledge, :count)

    expect(page).to have_text('error')
  end
end
