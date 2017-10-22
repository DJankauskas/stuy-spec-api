class MediaController < ApplicationController
  before_action :set_medium, only: [:show, :update, :destroy]

  # GET /media
  def index
    @media = Medium.all

    render json: @media
  end

  # GET /media/1
  def show
    render json: @medium
  end

  # POST /media
  def create
    if current_user.security_level >= 2
      @medium = Medium.new(medium_params)

      if @medium.save
        render json: @medium, status: :created, location: @medium
      else
        render json: @medium.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /media/1
  def update
    if current_user.security_level >= 2
      if @medium.update(medium_params)
        render json: @medium
      else
        render json: @medium.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /media/1
  def destroy
    if current_user.security_level == 3
      @medium.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medium
      @medium = Medium.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def medium_params
      params.require(:medium).permit(:user_id, :article_id, :url, :title, :caption, :is_featured, :type)
    end
end
