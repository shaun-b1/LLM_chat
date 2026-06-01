# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [ :create ]

  def create
    user = User.new(sign_up_params)
      if user.save
        render json: UserSerializer.new(user).serializable_hash, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
  end
end
