class Category < ApplicationRecord
  belongs_to :project
  #belongs_to :task, class_name: "Task"
  has_many :tasks

  validates :title, presence: true
end
