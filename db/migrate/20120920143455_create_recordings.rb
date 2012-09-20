class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.string :sid
      t.string :url
      t.text :message
      t.integer :duration
      t.references :call

      t.timestamps
    end
  end
end
