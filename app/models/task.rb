class Task < ApplicationRecord
	belongs_to :project, foreign_key: 'project_id', class_name: "Project"
	belongs_to :author, foreign_key: 'author_id', class_name: "User"
	belongs_to :assignee, foreign_key: 'assignee_id', class_name: "User", optional: true
	has_many :subtasks, class_name: "Task", foreign_key: 'parent_task_id'
	belongs_to :parent_task, class_name: "Task", optional: true
	has_many :updates

	validates :status, presence: true
	validates :title, presence: true

	#has_one :category, class_name: "Category", foreign_key: 'category_id'
	belongs_to :category

	paginates_per 3
	#work with controller
end
