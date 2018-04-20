class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }
  
  has_many :messages, dependent: :destroy
  has_many :micropost_messages, through: :messages, source: :micropost
  has_many :user_messages, through: :messages, source: :user
  
  def comment?(micropost)
    self.micropost_messages.include?(micropost)
  end
  
  def do_comment?(user)
    self.user_messages.include?(user)
  end

end
