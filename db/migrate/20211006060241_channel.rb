class Channel < ActiveRecord::Migration[5.2]
  def change
    create_table :channels do |t|
      t.string :channel_id
      t.string :name
      t.string :airtable_id

      t.timestamps
    end
  end
end
