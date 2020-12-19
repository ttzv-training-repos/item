class CreateSmsSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :sms_settings do |t|
      t.references :user
      t.boolean :default, default: false
      t.string :token
      t.string :sender_name

      t.timestamps
    end
  end
end
