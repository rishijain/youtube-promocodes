require "uri"
require "json"
require "net/http"

class FetchVideoDescription
  YOUTUBE_API_KEY = Apikey.first.value

  def initialize(channel_id, playlist_id)
    @playlist_id = playlist_id
    @channel_id = channel_id
    @video_owner_title =  nil
  end

  def exec
    @description_ids = []
    @video_ids = []
    @published_at = []
    @descriptions = fetch_all_descriptions
    if @descriptions.any?
      create_descriptions
    end
    Description.where(id: @description_ids)
  end

  private

  def fetch_all_descriptions
    count = 0
    next_page_token = 'start'
    desc = []


    while(!next_page_token.nil?)
      path = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=#{@playlist_id}&key=#{YOUTUBE_API_KEY}&maxResults=25"
      path += "&pageToken=#{next_page_token}" if next_page_token != 'start'
      url = URI(path)
      puts url

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)

      response = https.request(request)
      body = JSON.parse(response.body)

      next_page_token = body['nextPageToken']

      videos = body['items']
      videos.each do |video|
        count += 1
        puts count

        desc << video['snippet']['description']
        @video_ids << video['snippet']['resourceId']['videoId']
        @video_owner_title = video['snippet']['videoOwnerChannelTitle']
        @published_at << video['snippet']['publishedAt']
      end
    end
    desc
  end

  def create_descriptions
    @descriptions.each_with_index do |desc, index|
      puts index
      d = Description.create(info: desc, playlist_id: @playlist_id, channel_id: @channel_id, video_id: @video_ids[index], channel_title: @video_owner_title, published_at: @published_at[index])
      @description_ids << d.id
    end
  end
end
