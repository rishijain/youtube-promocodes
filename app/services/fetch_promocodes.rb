class FetchPromocodes
  def initialize(desc)
    @desc = desc
    @promo_patterns = ['free trial', 'use my code', 'use code', 'discount']
  end

  def exec
    @desc.info.split("\n").each do |each_desc|
      Discountcode.find_or_create_by(code: each_desc) if @promo_patterns.any? { |h| each_desc.include?(h) }
    end
  end
end
