class FetchPromocodes
  def initialize(desc)
    @desc = desc
    @promo_patterns = ['free trial', 'use my code', 'use code', 'use the code', 'discount code', 'avail discount', 'discount of', 'maximum discount', 'Get my FREE', "% off", 'use the coupon ', 'use coupon', 'coupon code']
  end

  def exec
    splitted_desc = @desc.info.split("\n")
    splitted_desc.each_with_index do |each_desc, index|
      if @promo_patterns.any? { |h| each_desc.downcase.include?(h) }
        if each_desc.include?('http')
          code = each_desc
        elsif index != 0 && splitted_desc[index-1].include?('http')
          code = splitted_desc[index-1] + " " + each_desc
        elsif splitted_desc[index+1].include?('http')
          code = each_desc + " " + splitted_desc[index+1]
        else
          code = each_desc
        end

        Discountcode.find_or_create_by(code: code, video_id: @desc.video_id, playlist_id: @desc.playlist_id, published_at: @desc.published_at, channel_title: @desc.channel_title, channel_id: @desc.channel_id, description_id: @desc.id)

      end
    end
  end
end
