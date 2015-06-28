class ContactGroup < ActiveRecord::Base
  has_many :contact_group_contacts
  has_many :contacts, through: :contact_group_contacts
end
