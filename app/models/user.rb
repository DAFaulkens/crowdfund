class User < ActiveRecord::Base
  has_secure_password
  has_many :pledges, dependent: :destroy
  has_many :passions, dependent: :destroy
  has_many :causes, through: :passions, source: :project

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /\A\S+@\S+\z/


  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end
end
