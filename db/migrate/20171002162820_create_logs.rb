class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|
      t.string :who
      t.string :head
      t.string :body
      t.string :level

      t.timestamps
    end
  end
end
