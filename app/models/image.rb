class Image < ApplicationRecord
  belongs_to :proto, required: false
  enum role: { sub: 0, main: 1 }
end
