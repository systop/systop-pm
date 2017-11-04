class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :tasks, :category, :category_id
  end
end
