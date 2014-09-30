class Pledge < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  AMOUNTS = [25, 50, 100, 200, 500]
  validates :amount, inclusion: { in: AMOUNTS }
end
