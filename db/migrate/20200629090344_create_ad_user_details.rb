class CreateAdUserDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_user_details do |t|
      t.integer :office_id
      t.string :position
      t.references :ad_user

      t.timestamps
    end
  end
end
