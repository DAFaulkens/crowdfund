require 'spec_helper'

describe "Unliking a cause" do
  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end

  it "deletes the favorite and shows the 'Like' button" do
    project = Project.create!(project_attributes)

    visit project_url(project)
    click_button 'Like'

    expect {
      click_button 'Unlike'
    }.to change(@user.causes, :count).by(-1)
    expect(current_path).to eq(project_path(project))
    expect(page).to have_button('Like')
  end
end
