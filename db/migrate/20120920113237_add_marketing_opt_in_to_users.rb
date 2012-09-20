class AddMarketingOptInToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :marketing_opt_in 
    end
  end
end
