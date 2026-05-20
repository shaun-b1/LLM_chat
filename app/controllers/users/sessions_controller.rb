# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    if current_user
      render json: UserSerializer.new(current_user).serializable_hash, status: :ok
    else
      head :unauthorized
    end
  end

  def destroy
    sign_out(current_user)
  end

  def respond_to_on_destroy(non_navigational_status: :no_content)
    if current_user
      head :no_content
    else
      head :unauthorized
    end
  end
end
