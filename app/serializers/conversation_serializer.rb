class ConversationSerializer
  include JSONAPI::Serializer
  attributes :created_at

  has_many :users

  attribute :last_message do |conversation|
    message = conversation.last_message
    # using Ruby's safe navigation operator, rather than a conditional block
    message && { created_at: message.created_at, content: message.content }
  end
end
