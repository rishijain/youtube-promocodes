class Channel
  include Mongoid::Document

  field :channel_id
  field :name

  field :airtable_id


  def push_to_airtable
    return if self.airtable_id
    key = Apikey.find_by name: 'airtable'
    client = Airtable::Client.new(key.value)
    app_key = Apikey.find_by name: 'airtable_app_key'
    table = client.table(app_key.value, "channels")
    new_record = Airtable::Record.new(:name => name, :channel_id => channel_id)
    puts new_record.inspect
    air_record = table.create(new_record)
    if air_record
      self.airtable_id = air_record[:id]
      self.save
    end
  end
end
