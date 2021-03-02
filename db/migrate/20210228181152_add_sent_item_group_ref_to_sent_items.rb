class AddSentItemGroupRefToSentItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :sent_items, :sent_item_group, null: false, foreign_key: true
  end
end
