class Project < ActiveRecord::Base

  has_many :pledges, dependent: :destroy
  has_many :passions, dependent: :destroy
  has_many :supporters, through: :passions, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :categories, through: :characterizations

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

  scope :ongoing, -> { where("pledging_ends_on >= ?", Date.today).order("pledging_ends_on ASC") }
  scope :past, -> { where("pledging_ends_on < ?", Date.today).order("pledging_ends_on DESC") }
  scope :recently_added, ->(max=5) { order("created_at DESC").limit(max) }


  def expired?
    pledging_ends_on < Date.today
  end

  def total_amount_pledged
    pledges.sum(:amount)
  end

  def amount_outstanding
    target_pledge_amount - total_amount_pledged
  end

  def funded?
    amount_outstanding <= 0
  end
end
