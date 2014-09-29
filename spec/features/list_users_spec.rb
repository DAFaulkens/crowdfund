require 'spec_helper'

describe "Listing the users" do
  
  it "shows the users" do
    user1 = User.create!(user_attributes(name: "larry", username: "larry", email: "larry@example.com"))
    user2 = User.create!(user_attributes(name: "curly", username: "curly", email: "curly@example.com"))
    user3 = User.create!(user_attributes(name: "moe", username: "moe", email: "moe@example.com"))

    visit users_url

    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.name)
    expect(page).to have_link(user3.name)
  end
end
