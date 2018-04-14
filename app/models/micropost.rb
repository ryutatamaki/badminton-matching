class Micropost < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }
  
  has_many :messages
  has_many :reply, through: :messages, source: :micropost
  
  def reply(micropost)
    self.messages.find(micropost_id: micropost.id)
  end

end
