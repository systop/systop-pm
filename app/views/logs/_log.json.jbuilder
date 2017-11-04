json.extract! log, :id, :who, :head, :body, :level, :created_at, :updated_at
json.url log_url(log, format: :json)
