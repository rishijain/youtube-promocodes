class Description
  include Mongoid::Document

  field :info
  field :playlist_id
  field :channel_id
  field :channel_title
  field :video_id
  field :published_at
end
