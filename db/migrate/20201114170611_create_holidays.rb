class CreateHolidays < ActiveRecord::Migration[6.0]
  def change
    create_table :holidays do |t|

      t.timestamps
    end
  end
end
