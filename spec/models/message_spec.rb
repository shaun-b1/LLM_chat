require 'rails_helper'

RSpec.describe Message, type: :model do
  it "validates the presence of message content" do
    message = create(:message)

    expect(message).to validate_presence_of(:content)
  end
end
