# register models
class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_many :projects, as: :owned_projects
  
  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }
  
  def self.login(email, password)
    user = User.where(:email => email, :password => password).first
    if user
      token = get_token
      user.token = token
      user.save
      token
    end
  end
  
  def self.get_token
    rand(36**32).to_s(36)
  end
end

class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :user
  
  validates :name, :key, :status, :user, presence: true
  validates :key, uniqueness: true
  validates :status, inclusion: { in: %w(todo progress done failed), message: "%{value} is not a valid status" }
end