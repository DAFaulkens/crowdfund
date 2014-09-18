class Project < ActiveRecord::Base

  def expired?
    pledging_ends_on < Date.today
  end

  def self.ongoing
    where("pledging_ends_on >= ?", Date.today).order("pledging_ends_on ASC")
  end

  def self.major
    where("target_pledge_amount > ?", 100000).order("pledging_ends_on ASC")
  end
end
