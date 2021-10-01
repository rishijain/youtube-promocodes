class FetchPromocodes
  def initialize(desc)
    @desc = desc
    @promo_patterns = ['free trial', 'use my code', 'use code', 'use the code', 'discount code', 'avail discount', 'discount of', 'maximum discount', 'Get my FREE', '% off', 'use the coupon ', 'use coupon', 'coupon code']
  end

  def exec
    @desc.info.split("\n").each do |each_desc|
      Discountcode.find_or_create_by(code: each_desc, video_id: @desc.video_id, playlist_id: @desc.playlist_id, published_at: @desc.published_at,
                                     channel_title: @desc.channel_title, channel_id: @desc.channel_id, description_id: @desc.id) if @promo_patterns.any? { |h| each_desc.downcase.include?(h) }
    end
  end
end
