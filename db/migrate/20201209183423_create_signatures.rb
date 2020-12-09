class CreateSignatures < ActiveRecord::Migration[6.0]
  def change
    create_table :signatures do |t|
      t.text :content

      t.timestamps
    end
  end
end
