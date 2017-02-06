class Proto < ApplicationRecord
  belongs_to :user
  has_many :images
  has_one :main_image, -> { where role: 'main' }, class_name: 'Image'
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :catchcopy, :concept, presence: true
  after_initialize :build_main_image, :build_sub_images, if: :new_record?

  SUB_IMAGES_NUMBER= 3

  def sub_images
    images.select(&:sub?)
  end

  def new_record?
    id.nil? && title.nil? && concept.nil? && catchcopy.nil?
  end

  private

  def build_main_image
    images << Image.new(role: :main)
  end

  def build_sub_images
    SUB_IMAGES_NUMBER.times { images << Image.new(role: :sub) }
  end
end
