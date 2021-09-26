require 'nokogiri'
require 'open-uri'

class FetchChannel

  def initialize(video_url)
    @video_url = video_url
  end

  def exec
    puts "fetching channel id for #{@video_url}"
    document = Nokogiri::HTML(URI.send(:open, @video_url))
    prop = document.at('meta[itemprop="channelId"]')
    if prop.nil?
      puts "channel id not found in url #{@video_url}, check video url"
      'not_found'
    else
      puts document.at('meta[itemprop="channelId"]')['content']
      document.at('meta[itemprop="channelId"]')['content']
    end
  end
end
