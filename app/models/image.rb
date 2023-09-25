class Image < ApplicationRecord
  belongs_to :post
  has_one_attached :image_file
end
