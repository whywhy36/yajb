class AddFieldsToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :link, :string, default: '#'
    add_column :orgs, :desc, :string, default: 'Description'
    add_column :orgs, :contact, :string, default: 'Contact info'
  end
end
