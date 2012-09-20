class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :sid
      t.string :caller_number
      t.datetime :call_time
      t.references :user

      t.timestamps
    end
  end
end
