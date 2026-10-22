# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    if current_user
      render json: UserSerializer.new(current_user).serializable_hash, status: :ok
    else
      head :unauthorized
    end
  end

  def destroy
    return head :unauthorized unless current_user

    sign_out(current_user)
    respond_to_on_destroy
  end

  def respond_to_on_destroy(*)
    head :no_content
  end

  def verify_signed_out_user
  end
end
