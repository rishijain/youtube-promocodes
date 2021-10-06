class Discountcode < ActiveRecord::Migration[5.2]
  def change
    create_table :discountcodes do |t|
      t.string :channel_id
      t.string :channel_title
      t.string :playlist_id
      t.string :video_id
      t.string :code
      t.string :description_id
      t.string :airtable_id
      t.string :promourl
      t.boolean :ignore

      t.timestamp :published_at
      t.timestamps
    end
  end
end
