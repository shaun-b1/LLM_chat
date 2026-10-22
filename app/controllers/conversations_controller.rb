class ConversationsController < ApplicationController
  before_action :set_conversation, only: [ :show ]

  def index
    render json: ConversationSerializer.new(current_user.conversations, is_collection: true).serializable_hash
  end

  def show
    render json: ConversationSerializer.new(@conversation).serializable_hash
  end

  def create
    participant_ids = conversation_params[:participant_ids] + [ current_user.id ]
    conversation = Conversation.find_between(participant_ids).first
    if conversation
      render json: ConversationSerializer.new(conversation).serializable_hash
    else
      ActiveRecord::Base.transaction do
        conversation = Conversation.create!
        participant_ids.each do |user_id|
          conversation.conversation_participants.create!(user_id: user_id)
        end
      end
      render json: ConversationSerializer.new(conversation).serializable_hash
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: ErrorSerializer.new(e.record.errors, :unprocessable_entity).serialize, status: :unprocessable_entity
  end

  private

  def conversation_params
    params.require(:conversation).permit(participant_ids: [])
  end

  def set_conversation
    @conversation = current_user.conversations.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :forbidden
  end
end
