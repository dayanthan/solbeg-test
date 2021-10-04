class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :avatar, null: false
      t.string :phone_no, null: false
      t.string :landmark, null: false
      t.string :street, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.integer :pincode, null: false
      t.string :state, null: false

      t.timestamps
    end
  end
end
