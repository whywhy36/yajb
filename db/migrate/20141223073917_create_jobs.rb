class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :jd
      t.references :category, index: true
      t.references :type, index: true
      t.references :org, index: true

      t.timestamps null: false
    end
    add_foreign_key :jobs, :categories
    add_foreign_key :jobs, :types
    add_foreign_key :jobs, :orgs
  end
end
