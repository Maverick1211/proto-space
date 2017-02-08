class Image < ApplicationRecord
  enum role: { sub: 0, main: 1 }
  mount_uploader :image, ImageUploader

  belongs_to :proto, required: false
end
