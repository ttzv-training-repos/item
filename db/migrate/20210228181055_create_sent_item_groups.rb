class CreateSentItemGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :sent_item_groups do |t|

      t.timestamps
    end
  end
end
