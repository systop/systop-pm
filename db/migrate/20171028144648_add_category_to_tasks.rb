class AddCategoryToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :category, :string
  end
end
