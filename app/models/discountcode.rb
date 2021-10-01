class Discountcode
  include Mongoid::Document

  field :code
  field :playlist_id
  field :channel_id
  field :channel_title
  field :video_id
  field :published_at
  field :description_id

  field :ignore
end
