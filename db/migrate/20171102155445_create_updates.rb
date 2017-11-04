class CreateUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :updates do |t|
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true
      t.text :body
      t.text :comment

      t.timestamps
    end
  end
end
