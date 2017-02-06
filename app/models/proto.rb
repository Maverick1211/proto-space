class Proto < ApplicationRecord
  belongs_to :user
  has_many :images
  has_one :main_image, -> { where role: 'main' }, class_name: 'Image'
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :catchcopy, :concept, presence: true

  def sub_images
    images.select(&:sub?)
  end
end
