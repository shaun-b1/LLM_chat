require 'rails_helper'

RSpec.describe ConversationParticipant, type: :model do
  it "validates the uniqueness of the users in the conversation" do
    user = create(:user)
    conversation = create(:conversation)
    conversation_participant = create(:conversation_participant, conversation: conversation, user: user)

    expect(conversation_participant).to validate_uniqueness_of(:user_id).scoped_to(:conversation_id)
  end
end
