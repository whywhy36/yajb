class AddStatusToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :status, :string, :default => "open"
  end
end
