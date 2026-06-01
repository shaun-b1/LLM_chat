require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it "destroys associated conversation participants when destroyed" do
    conversation = create(:conversation)
    create(:conversation_participant, conversation: conversation)

    expect { conversation.destroy }.to change { ConversationParticipant.count }.by(-1)
  end

  it "destroys associated messages when destroyed" do
    conversation = create(:conversation)
    create(:message, conversation: conversation)

    expect { conversation.destroy }.to change { Message.count }.by(-1)
  end

  it "has many users through conversation participants" do
    user = create(:user)
    conversation = create(:conversation)
    create(:conversation_participant, user: user, conversation: conversation)

    expect(conversation.users).to include(user)
  end
end
