class Pledge < ActiveRecord::Base
  belongs_to :project

  validates :name, :email, presence: true
  validates :email, format: { with: /(\S+)@(\S+)/ }
  AMOUNTS = [25, 50, 100, 200, 500]
  validates :amount, inclusion: { in: AMOUNTS }
end
