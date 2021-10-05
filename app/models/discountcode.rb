class Discountcode
  include Mongoid::Document

  field :code
  field :playlist_id
  field :channel_id
  field :channel_title
  field :video_id
  field :published_at
  field :description_id
  field :airtable_id
  field :promourl

  field :ignore

  validates :code, uniqueness: true, presence: true

  def push_to_airtable
    return if self.airtable_id
    key = Apikey.find_by name: 'airtable'
    client = Airtable::Client.new(key.value)
    app_key = Apikey.find_by name: 'airtable_app_key'
    table = client.table(app_key.value, "promocodes")
    new_record = Airtable::Record.new(:code => code, :u_id => id.to_s, channel_title: channel_title, visible: 'true', created_on: DateTime.now, promourl: promourl)
    puts new_record.inspect
    air_record = table.create(new_record)
    if air_record
      self.airtable_id = air_record[:id]
      self.save
    end
  end
end
