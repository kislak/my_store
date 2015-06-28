class CreateContactGroupContacts < ActiveRecord::Migration
  def change
    create_table :contact_group_contacts do |t|
      t.references :contact_group
      t.references :contact

      t.timestamps null: false
    end
  end
end
