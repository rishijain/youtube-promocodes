class Discountcode
  include Mongoid::Document

  field :code
  field :creator
  field :channel_name

  field :ignore
end
