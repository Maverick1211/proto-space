class Proto < ApplicationRecord
  include ActiveRecordExpander

  after_initialize :build_main_image, :build_sub_images, if: -> { new_record?(true) }

  belongs_to :user
  has_many :images
  has_one :main_image, -> { where role: 'main' }, class_name: 'Image'
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :catchcopy, :concept, presence: true

  def sub_images
    images.select(&:sub?)
  end

  private

  def build_main_image
    images << Image.new(role: :main)
  end

  def build_sub_images
    Settings[:SUB_IMAGES_NUMBER].times { images << Image.new(role: :sub) }
  end
end
