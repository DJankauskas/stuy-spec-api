class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    if current_user.security_level >= 2
      @users = User.all

      render json: @users
    end
  end

  # GET /users/1
  def show
    if current_user.id == @user.id or current_user.security_level >= 2
      render json: @user
    end
  end

  # POST /users
  def create
    params[:security_level] = 1
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if current_user.id == @user.id or current_user.security_level == 3
      if current_user.security_level < 3
        params[:security_level] = 1
      end
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /users/1
  def destroy
    if current_user.id == @user.id or current_user.security_level == 3
      @user.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :description, :slug, :security_level)
    end
end
