class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  wrap_parameters :user, include: [:email, :password, :first_name, :last_name]

  # POST /login
  def show
    if @user.authenticate(params[:password])
      render json: @user, status: :authenticated, location: @user
    else
      render json: { error: 'Unauthorized', status: 401 }, status: :unauthorized
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(email: params[:email])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {}).permit(
        :first_name,
        :last_name,
        :email,
        :password
      )
    end
end
