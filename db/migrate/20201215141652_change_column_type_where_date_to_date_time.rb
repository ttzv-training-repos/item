class ChangeColumnTypeWhereDateToDateTime < ActiveRecord::Migration[6.0]
  def change 
    change_table :ad_users do |t|
    t.change :whencreated, :datetime
    t.change :whenchanged, :datetime
    t.change :badpasswordtime, :datetime
    t.change :lastlogoff, :datetime
    t.change :lastlogon, :datetime
    t.change :pwdlastset, :datetime
    t.change :accountexpires, :datetime
    t.change :lockouttime, :datetime
    t.change :lastlogontimestamp, :datetime
    end
  end
end
