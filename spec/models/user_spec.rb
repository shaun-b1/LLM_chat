require 'rails_helper'

RSpec.describe User, type: :model do
  it "destroys associated conversation participants when destroyed" do
    user = create(:user)
    create(:conversation_participant, user: user)

    expect { user.destroy }.to change { ConversationParticipant.count }.by(-1)
  end

  it "destroys associated messages when destroyed" do
    user = create(:user)
    create(:message, user: user)

    expect { user.destroy }.to change { Message.count }.by(-1)
  end

  it "has many conversations through conversation participants" do
    user = create(:user)
    conversation = create(:conversation)
    create(:conversation_participant, user: user, conversation: conversation)

    expect(user.conversations).to include(conversation)
  end
end
