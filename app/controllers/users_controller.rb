class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: [:index, :update, :destroy]
  wrap_parameters :user, include: [:email, :password, :profile_pic, :first_name, :last_name]

  def index
    render json: @user, status: :ok
  end

  # POST /signup
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    if @user.authenticate(user_params[:password]) && params[:id].to_i == current_user.id.to_i
      Attending.where("user_id = ?", current_user.id).destroy_all
      Event.where("user_id = ?", current_user.id).destroy_all
      @user.destroy
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private
    def set_user
      @user = User.find(current_user.id)
    end

    def user_params
      params.fetch(:user, {}).permit(
        :first_name,
        :last_name,
        :email,
        :profile_pic,
        :password
      )
    end
end
