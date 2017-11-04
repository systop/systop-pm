class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :author_id
      t.references :project
      t.integer :assignee_id
      t.integer :parent_task_id
      t.integer :sub_task_id

      t.timestamps
    end
  end
end
