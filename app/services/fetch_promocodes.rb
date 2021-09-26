class FetchPromocodes
  def initialize(desc)
    @desc = desc
    @promo_patterns = ['free trial', 'use my code', 'use code', 'use the code', 'discount code', 'avail discount', 'discount of', 'maximum discount', 'Get my FREE']
  end

  def exec
    @desc.info.split("\n").each do |each_desc|
      Discountcode.find_or_create_by(code: each_desc) if @promo_patterns.any? { |h| each_desc.downcase.include?(h) }
    end
  end
end
