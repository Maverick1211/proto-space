class Proto < ApplicationRecord
  belongs_to :user
  has_many :images
  has_one :image, -> { where(role: "main") }
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :catchcopy, :concept, presence: true
end
