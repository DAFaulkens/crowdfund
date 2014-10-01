class Category < ActiveRecord::Base

  has_many :characterizations, dependent: :destroy
  has_many :projects, through: :characterizations
  validates :name, presence: true, uniqueness: true

end
