require 'spec_helper'

describe "Liking a cause" do
  before do
    @user = User.create!(user_attributes)
    sign_in(@user)
  end

  it "creates a like for the signed-in user and shows the 'Unlike' button" do
    project = Project.create!(project_attributes)
    
    visit project_url(project)

    expect { 
      click_button 'Like'
    }.to change(@user.causes, :count).by(1)
    expect(current_path).to eq(project_path(project))

    expect(page).to have_button('Unlike')
  end
end
