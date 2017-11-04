json.extract! admin_setting, :id, :title, :alias, :value, :description, :for, :created_at, :updated_at
json.url admin_setting_url(admin_setting, format: :json)
