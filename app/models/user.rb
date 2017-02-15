class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true
  has_many :protos
  has_many :comments, dependent: :destroy
end
