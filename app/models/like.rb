class Like < ApplicationRecord
  belongs_to :proto, counter_cache: :likes_count
  belongs_to :user
end
