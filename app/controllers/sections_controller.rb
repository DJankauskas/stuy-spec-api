class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :update, :destroy]

  # GET /sections
  def index
    @sections = Section.all

    render json: @sections
  end

  # GET /sections/1
  def show
    render json: @section
  end

  # POST /sections
  def create
    if current_user.security_level >= 2
      if current_user.security_level == 2
        params[:is_visible] = false
      end
      @section = Section.new(section_params)

      if @section.save
        render json: @section, status: :created, location: @section
      else
        render json: @section.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /sections/1
  def update
    if current_user.security_level >= 2
      if current_user.security_level == 2
        params[:is_visible] = false
      end
      if @section.update(section_params)
       render json: @section
      else
        render json: @section.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /sections/1
  def destroy
    if current_user.security_level == 3
      @section.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def section_params
      params.require(:section).permit(:name, :description, :slug, :parent_id, :rank, :is_visible)
    end
end
