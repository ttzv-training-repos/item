class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.integer :user_id
      t.string :mail_adapter

      t.timestamps
    end
  end
end
