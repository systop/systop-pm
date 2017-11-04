class CreateAdminSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :admin_settings do |t|
      t.string :title
      t.string :alias
      t.string :value
      t.text :description
      t.string :for

      t.timestamps
    end
  end
end
