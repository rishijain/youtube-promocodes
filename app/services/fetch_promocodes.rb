class FetchPromocodes
  def initialize(desc)
    @desc = desc
    @promo_patterns = ['free trial', 'use my code', 'use code', 'use the code', 'discount code', 'avail discount', 'discount of', 'maximum discount', 'Get my FREE', "% off", 'use the coupon ', 'use coupon', 'coupon code']
  end

  def exec
    splitted_desc = @desc.info.split("\n").select {|g| g if !g.blank? }
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

        disc_code = Discountcode.find_by(code: code, channel_title: @desc.channel_title)
        channel_obj = Channel.find_by name: @desc.channel_title
        channel_obj.push_to_airtable if channel_obj && channel_obj.airtable_id.nil?

        if disc_code.nil?
          promourl = URI.extract(code).select {|g| g.include?('http')}[0] || nil
          disc_code = Discountcode.create(code: code, video_id: @desc.video_id, playlist_id: @desc.playlist_id, published_at: @desc.published_at,
                                          channel_title: @desc.channel_title, channel_id: @desc.channel_id, description_id: @desc.id.to_s, promourl: promourl)

          disc_code.push_to_airtable

        end

      end
    end
  end
end
