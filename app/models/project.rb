class Project < ApplicationRecord
  has_many :roles
  has_many :users, :through => :roles
  has_many :tasks
  has_many :categories

  validates :title, presence: true
end
