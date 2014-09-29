require 'spec_helper'

describe "Deleting a user" do
  
  it "deletes the account and redirects to the home page" do
    user = User.create!(user_attributes)

    visit user_url(user)
    click_link 'Delete'

    expect(current_path).to eq(root_path)
    expect(page).to have_text("Account Successfully Deleted!")

    visit users_path
    expect(page).not_to have_text(user.name)
  end
end
