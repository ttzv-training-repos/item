class AddColumnsToSentItems < ActiveRecord::Migration[6.0]
  def change
    add_column :sent_items, :recipients, :text
    add_column :sent_items, :fields, :text
  end
end
