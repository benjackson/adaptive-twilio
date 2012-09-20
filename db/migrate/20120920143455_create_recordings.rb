class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :sid
      t.string :url
      t.text :message
      t.string :caller_number
      t.datetime :call_time
      t.references :user

      t.timestamps
    end
  end
end
