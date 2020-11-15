class CreateInboxes < ActiveRecord::Migration[6.0]
  def change
    create_table :inboxes do |t|
      t.references :employee
      t.timestamps
    end
  end
end
