class Contact < ActiveRecord::Base
  has_many :contact_group_contacts
  has_many :contact_groups, through: :contact_group_contacts
end
