class CreateBlogPermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :blog_permissions do |t|
      t.integer :user_id
      t.references :blog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
