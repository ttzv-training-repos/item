class AddColumnOAuthScopeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :oauth_scope, :text
  end
end
