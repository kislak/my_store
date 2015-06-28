class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :from
      t.string :message
      t.text :list

      t.timestamps null: false
    end
  end
end
