class CreateTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :templates do |t|
      t.string :name
      t.string :applies_to

      t.timestamps
    end
  end
end
