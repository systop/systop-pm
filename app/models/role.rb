class Role < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :user, uniqueness: { scope: [:title, :project],
    message: "just has that role in this project" }
end
