class Like < ApplicationRecord
  belongs_to :proto, counter_cache: :likes_count
  belongs_to :user

  validates :user_id, uniqueness: { scope: :proto_id }
end
