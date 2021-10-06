require "uri"
require "json"
require "net/http"

class FetchPlaylist

  def initialize(channel_id)
    @channel_id = channel_id
    @youtube_api_key = Apikey.first.value
  end

  def exec
    url = URI("https://www.googleapis.com/youtube/v3/channels?part=contentDetails&id=#{@channel_id}&key=#{@youtube_api_key}&maxResults=25")

    puts  url
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    body =  JSON.parse(response.body)
    puts body
    if body['items']
      puts body['items'][0]['contentDetails']['relatedPlaylists']['uploads']
      body['items'][0]['contentDetails']['relatedPlaylists']['uploads']
    else
      puts  "no playlist founnd for #{@channel_id}"
      'not_found'
    end
  end
end
