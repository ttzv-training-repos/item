class CreateSmtpSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :smtp_settings do |t|
      t.string :address
      t.integer :port
      t.string :domain
      t.string :user_name
      t.string :password
      t.string :authentication
      t.boolean :tls
      t.integer :user_id

      t.timestamps
    end
  end
end
