class RolesController < ApplicationController
  before_action :set_role, only: [:show, :update, :destroy]

  # GET /roles
  def index
    @roles = Role.all

    render json: @roles
  end

  # GET /roles/1
  def show
    render json: @role
  end

  # POST /roles
  def create
    if current_user.security_level == 3
      @role = Role.new(role_params)

      if @role.save
        render json: @role, status: :created, location: @role
      else
        render json: @role.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /roles/1
  def update
    if current_user.security_level == 3
      if @role.update(role_params)
        render json: @role
      else
        render json: @role.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /roles/1
  def destroy
    if current_user.security_level == 3
      @role.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def role_params
      params.require(:role).permit(:title, :slug)
    end
end
