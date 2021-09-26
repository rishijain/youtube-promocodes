require "uri"
require "json"
require "net/http"

class FetchVideoDescription
  YOUTUBE_API_KEY = Apikey.first.value

  def initialize(playlist_id)
    @playlist_id = playlist_id
  end

  def exec
    @descriptions = fetch_all_descriptions
    if @descriptions.any?
      create_descriptions
    end
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
      end
    end
    desc
  end

  def create_descriptions
    @descriptions.each_with_index do |desc, index|
      puts index
      Description.create(info: desc)
    end
  end
end
