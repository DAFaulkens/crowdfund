require 'spec_helper'

describe "Creating a user" do
  
  it "creates the user and redirects to the user's profile page" do
    visit root_path
    click_link 'Sign Up'

    expect(current_path).to eq(signup_path)

    fill_in 'Name', with: "Example"
    fill_in 'Username', with: "Example"
    fill_in 'Email', with: "user@example.com"
    fill_in 'Password', with: "foobar"
    fill_in 'Password Confirmation', with: "foobar"
    click_button 'Create Account'

    expect(current_path).to eq(user_path(User.last))
  end

  it "does not create the user with invalid data" do
    visit signup_url
    expect {
      click_button 'Create Account'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
  end
end
