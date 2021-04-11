class AddColumnAuthorToSentItemGroup < ActiveRecord::Migration[6.0]
  def change
    add_column :sent_item_groups, :creator, :string
  end
end
