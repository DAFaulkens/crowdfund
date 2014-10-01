require 'spec_helper'

describe "A project" do
  
  it "has expired if the pledging ends on date is in the past" do
    project = Project.new(pledging_ends_on: 20.days.ago)

    expect(project.expired?).to eq(true)
  end

  it "has not expired if the pledging ends on date is in the future" do
    project = Project.new(pledging_ends_on: 20.days.from_now)
    
    expect(project.expired?).to eq(false)
  end

  it "requires a name" do
    project = Project.new(name: "")

    project.valid?

    expect(project.errors[:name].any?).to eq(true)
  end

  it "requires a description" do
    project = Project.new(description: "")

    project.valid?

    expect(project.errors[:description].any?).to eq(true)
  end

  it "accepts a description up to 500 characters" do
    project = Project.new(description: "X" * 501)

    project.valid?

    expect(project.errors[:description].any?).to eq(true)
  end

  it "accepts a positive target pledge amount" do
    project = Project.new(target_pledge_amount: 100.00)

    project.valid?

    expect(project.errors[:target_pledge_amount].any?).to eq(false)
  end

  it "rejects a $0 target pledge amount" do
    project = Project.new(target_pledge_amount: 0.00)

    project.valid? 

    expect(project.errors[:target_pledge_amount].any?).to eq(true)
  end

  it "rejects a negative target pledge amount" do
    project = Project.new(target_pledge_amount: -100.00)

    project.valid?

    expect(project.errors[:target_pledge_amount].any?).to eq(true)
  end

  it "accepts properly formatted website URLs" do
    sites = %w[http://example.com, https://example]
    sites.each do |site|
      project = Project.new(website: site)
      project.valid?
      expect(project.errors[:website].any?).to eq(false)
    end
  end

  it "rejects properly formatted website URLs" do
    sites = %w[example.com http examplehttp]
    sites.each do |site|
      project = Project.new(website: site)
      project.valid?
      expect(project.errors[:website].any?).to eq(true)
    end
  end

  it "accepts properly formatted image file names" do
    file_names = %w[e.png event.png event.jpg event.gif EVENT.GIF]
    file_names.each do |file|
      project = Project.new(image_file_name: file)
      project.valid?
      expect(project.errors[:image_file_name].any?).to eq(false)
    end
  end

  it "rejects improperly formatted image file names" do
    file_names = %w[event .jpg .png .gif event.pdf event.doc]
    file_names.each do |file|
      project = Project.new(image_file_name: file)
      project.valid?
      expect(project.errors[:image_file_name].any?).to eq(true)
    end
  end

  it "has many pledges" do
    project = Project.new(project_attributes)

    pledge1 = project.pledges.new(pledge_attributes)
    pledge2 = project.pledges.new(pledge_attributes)

    expect(project.pledges).to include(pledge1)
    expect(project.pledges).to include(pledge2)
  end

  it "deletes associated pledges" do
    project = Project.create(project_attributes)
    project.pledges.create(pledge_attributes)

    expect {
      project.destroy
    }.to change(Pledge, :count).by(-1)
  end

  it "calculates the total amount pledged as the sum of all the pledges" do
    project = Project.create!(project_attributes)
    project.pledges.create!(pledge_attributes(amount: 25.00))
    project.pledges.create!(pledge_attributes(amount: 100.00))

    expect(project.total_amount_pledged).to eq(125.00)
  end

  it "calculates the pledge amount outstanding" do
    project = Project.create!(project_attributes(target_pledge_amount: 100.00))
    project.pledges.create!(pledge_attributes(amount: 50.00))

    expect(project.amount_outstanding).to eq(50.00)
  end

  it "is funded is the target pledge amount has been reached" do
    project = Project.create!(project_attributes(target_pledge_amount: 100.00))
    project.pledges.create!(pledge_attributes(amount: 50.00))
    project.pledges.create!(pledge_attributes(amount: 50.00))

    expect(project.funded?).to eq(true)
  end
  
  it "is funded is the target pledge amount has been reached" do
    project = Project.create!(project_attributes(target_pledge_amount: 100.00))
    project.pledges.create!(pledge_attributes(amount: 50.00))

    expect(project.funded?).to eq(false)
  end

  it "has supporters" do
    project = Project.new(project_attributes)
    supporter1 = User.new(user_attributes(username: "user", email: "user@example.com"))
    supporter2 = User.new(user_attributes(username: "another", email: "another@example.com"))

    project.passions.new(user: supporter1)
    project.passions.new(user: supporter2)

    expect(project.supporters).to include(supporter1)
    expect(project.supporters).to include(supporter2)
  end

  context "ongoing query" do
    it "returns projects with an end date in the future" do
      project1 = Project.create!(project_attributes(pledging_ends_on: 3.months.ago))
      project2 = Project.create!(project_attributes(pledging_ends_on: 3.months.from_now)) 

      expect(Project.ongoing).to eq([project2])
    end
  end

  context "past query" do
    it "returns a project with an end date in the past" do
      project1 = Project.create!(project_attributes(pledging_ends_on: 3.months.ago))
      project2 = Project.create!(project_attributes(pledging_ends_on: 3.months.from_now)) 

      expect(Project.past).to eq([project1])
    end
  end

  context "recently added query" do
    before do
      @project1 = Project.create!(project_attributes(created_at: 3.months.ago))
      @project2 = Project.create!(project_attributes(created_at: 2.months.ago))
      @project3 = Project.create!(project_attributes(created_at: 1.months.ago))
      @project4 = Project.create!(project_attributes(created_at: 1.week.ago))
      @project5 = Project.create!(project_attributes(created_at: 1.day.ago))
      @project6 = Project.create!(project_attributes(created_at: 1.hour.ago))
    end

    it "returns a specified number of newly added projects ordered with the most recent first" do
      expect(Project.recently_added(2)).to eq([@project6, @project5])
    end

    it "returns a default of 5 recently added projects ordered with the most recent project first" do
      expect(Project.recently_added).to eq([@project6, @project5, @project4, @project3, @project2])
    end
  end
end
