class Image < ApplicationRecord
  belongs_to :proto
  enum role: { sub: 0, main: 1 }
end
