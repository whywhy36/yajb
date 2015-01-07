class AddUserRefToOrgs < ActiveRecord::Migration
  def change
    add_reference :orgs, :user, index: true
    add_foreign_key :orgs, :users
  end
end
