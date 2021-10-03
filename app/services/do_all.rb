class DoAll

  def initialize(url)
    @url = url
  end

  def exec
    cl = FetchChannel.new(@url).exec
    pl = FetchPlaylist.new(cl).exec
    FetchVideoDescription.new(cl, pl).exec
    Description.where(channel_id: cl).each { |d| FetchPromocodes.new(d).exec }
  end
end
