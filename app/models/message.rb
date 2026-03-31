class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user, optional: true

  validates :content, presence: true
end
