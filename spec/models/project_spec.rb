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
end
