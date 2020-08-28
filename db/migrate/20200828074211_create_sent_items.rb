class CreateSentItems < ActiveRecord::Migration[6.0]
  def change
    create_table :sent_items do |t|
      t.string :title
      t.string :type
      t.boolean :status
      t.text :content
      t.text :status_content

      t.timestamps
    end
  end
end
