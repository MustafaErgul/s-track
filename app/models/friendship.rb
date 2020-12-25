class Friendship < ApplicationRecord
  belongs_to :user
  # because friend table is not exits. this will reference from user tab
  belongs_to :friend, class_name: 'User'
end
