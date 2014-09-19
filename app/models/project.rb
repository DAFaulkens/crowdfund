class Project < ActiveRecord::Base

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :target_pledge_amount, numericality: { greater_than: 0 }

  validates :image_file_name, allow_blank: true, format: {
    with: /\w+.(png|gif|jpg)\z/i, 
    message: "must reference a GIF, JPG, or PNG image"
  }

  validates :website, format: {
    with: /https?:\/\/[\S]+\b/i, 
    message: "must reference a valid URL"
  }


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
