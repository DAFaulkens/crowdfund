require 'spec_helper'

describe "A pledge" do

  it "belongs to a project" do
    project = Project.create(project_attributes)

    pledge = project.pledges.new(pledge_attributes)

    expect(pledge.project).to eq(project)
  end

  it "with example attributes is valid" do
    pledge = Pledge.new(pledge_attributes)

    expect(pledge.valid?).to eq(true)
  end

  it "accepts valid amounts" do
    amounts = Pledge::AMOUNTS
    amounts.each do |amount|
      pledge = Pledge.new(amount: amount)
      pledge.valid?
      expect(pledge.errors[:amount].any?).to eq(false)
    end
  end

  it "rejects invalid amounts" do
    amounts = [-10.00, 0.00, 6.66, 1248.00]
    amounts.each do |amount|
      pledge = Pledge.new(amount: amount)
      pledge.valid?
      expect(pledge.errors[:amount].any?).to eq(true)
    end
  end
end
