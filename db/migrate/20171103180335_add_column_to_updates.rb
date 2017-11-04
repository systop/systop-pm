class AddColumnToUpdates < ActiveRecord::Migration[5.1]
  def change
    add_column :updates, :diff, :text
  end
end
