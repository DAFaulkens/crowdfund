require 'spec_helper'

describe "A User" do
  
  it "has a name" do
    user = User.new(name: "")

    user.valid?

    expect(user.errors[:name].any?).to eq(true)
  end

  it "has an email " do
    user = User.new(email: "")

    user.valid?

    expect(user.errors[:email].any?).to eq(true)
  end

  it "has a username " do
    user = User.new(username: "")

    user.valid?

    expect(user.errors[:username].any?).to eq(true)
  end

  it "has a unique username" do
    user = User.create!(user_attributes)
    user2 = User.new(username: user.username)

    user2.valid?
    
    expect(user2.errors[:username].first).to eq("has already been taken")
  end

  it "accepts properly formatted email addresses" do
    emails = %w[ foo@example.com first.last@example.com]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(false)
    end
  end

  it "accepts properly formatted email addresses" do
    emails = %w[ foo@ @example.com .com @ ] 
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(true)
    end
  end

  it "requires a unique, case-insensitive email address" do
    user = User.create!(user_attributes)
    user2 = User.new(email: user.email.upcase)

    user2.valid?
    expect(user2.errors[:email].first).to eq("has already been taken")
  end

  it "is valid with example attributes" do
    user = User.create!(user_attributes)

    expect(user.valid?).to eq(true)
  end

  it "requires a password" do
    user = User.new(password: "")

    user.valid?

    expect(user.errors[:password].any?).to eq(true)
  end

  it "requires a password confirmation when password is present" do
    user = User.new(password: "secret", password_confirmation: "")

    user.valid?

    expect(user.errors[:password_confirmation].any?).to eq(true)
  end

  it "requires a matching password confirmation" do 
    user = User.new(password: "secret", password_confirmation: "mismatch")

    user.valid?

    expect(user.errors[:password_confirmation].any?).to eq(true)
  end

  it "does not require a password when updating" do
    user = User.create!(user_attributes)

    user.password = ""

    expect(user.valid?).to eq(true)
  end

  it "automatically encrypts the password into the password_digest attribute" do
    user = User.new(password: "secret")

    expect(user.password_digest.present?).to eq(true)
  end

  it "has reviews" do
    user = User.new(user_attributes)
    project1 = Project.new(project_attributes(name: "Project A"))
    project2 = Project.new(project_attributes(name: "Project B"))

    pledge1 = project1.pledges.new(comment: "Let's do it!", amount: 200.00)
    pledge1.user = user
    pledge1.save!

    pledge2 = project2.pledges.new(comment: "Yes to this!", amount: 100.00)
    pledge2.user = user
    pledge2.save!

    expect(user.pledges).to include(pledge1)
    expect(user.pledges).to include(pledge2)
  end
end


describe "Authenticate" do
  before { @user = User.create!(user_attributes) } 

  it "returns false if the email doesn't match" do
    expect(User.authenticate("nomatch", @user.password)).not_to eq(true)
  end

  it "returns false if the password doesn't match" do
    expect(User.authenticate(@user.email, "nomatch")).not_to eq(true)
  end

  it "returns the user if the email and password match" do
    expect(User.authenticate(@user.email, @user.password)).to eq(@user)
  end
end
