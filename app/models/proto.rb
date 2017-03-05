class Proto < ApplicationRecord
  include ActiveRecordExpander
  include ActiveModel::Validations
  validates_with MainImageValidator

  after_initialize :build_main_image, :build_sub_images, if: -> { new_record?(true) }

  belongs_to :user
  has_many :images
  has_many :comments, dependent: :destroy
  has_one :main_image, -> { where role: 'main' }, class_name: 'Image'
  has_many :likes, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :catchcopy, :concept, presence: true

  scope :popular, -> { order(likes_count: :desc) }
  scope :newly, -> { order(created_at: :desc) }

  acts_as_taggable_on :tags

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def sub_images
    images.select(&:sub?)
  end

  private

  def build_main_image
    self.main_image = Image.new(role: 'main')
  end

  def build_sub_images
    Settings[:SUB_IMAGES_NUMBER].times { images << Image.new(role: :sub) }
  end
end
