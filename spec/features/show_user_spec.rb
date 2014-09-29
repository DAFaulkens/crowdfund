require 'spec_helper'

describe "Showing an individual user" do
  
  it "shows the user's profile page" do
    user = User.create!(user_attributes)

    visit user_url(user)
    
    expect(page).to have_text(user.username)
    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end
end
