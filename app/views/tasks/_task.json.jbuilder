json.extract! task, :id, :title, :description, :author_id, :project, :assignee_id, :parent_task_id, :sub_task_id, :created_at, :updated_at
json.url task_url(task, format: :json)
