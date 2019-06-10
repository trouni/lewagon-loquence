class UserPlatform < ApplicationRecord
  belongs_to :platform
  belongs_to :user
end
