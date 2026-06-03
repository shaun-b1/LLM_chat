class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :users, through: :conversation_participants
  has_many :messages, dependent: :destroy

  scope :find_between, ->(user_ids) {
    joins(:conversation_participants)
      .where(conversation_participants: { user_id: user_ids })
      .group(:id)
      .having("COUNT(conversation_participants.id) = ?", user_ids.length)
  }

  def last_message
    messages.order(created_at: :desc).first
  end
end
