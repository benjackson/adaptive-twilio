class AddTwilioNumberAndNameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.string :twilio_number
    end
  end
end
