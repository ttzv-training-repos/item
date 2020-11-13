class AddDefaultValueToAnonymousUser < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :anonymous, :boolean, default: true
  end
end
