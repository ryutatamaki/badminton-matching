class Message < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  
  validates :user_id, presence: true
  validates :comment, presence: true
end
