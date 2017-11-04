json.extract! update, :id, :task_id, :user_id, :body, :comment, :created_at, :updated_at
json.url update_url(update, format: :json)
