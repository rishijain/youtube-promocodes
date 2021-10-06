class Description < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptions do |t|
      t.string :channel_id
      t.string :channel_title
      t.string :playlist_id
      t.string :video_id
      t.string :info

      t.timestamp :published_at
      t.timestamps
    end
  end
end
