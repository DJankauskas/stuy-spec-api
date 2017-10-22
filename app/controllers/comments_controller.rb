class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  # GET /comments
  def index
    @comments = Comment.where.not(published_at: nil).all
    if params[:article_id]
      @comments = Article.friendly.find(params[:article_id]).comments
    elsif params[:user_id]
      @comments = User.friendly.find(params[:user_id]).comments
    end
    if params[:limit]
      limit = params[:limit]
      @comments = @comments.first(limit)
    end
    render json: @comments
  end

  # GET /comments/1
  def show
    if params[:article_id]
      if @comment.article_id == params[:article_id]
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    elsif params[:user_id]
      if @comment.user_id == params[:user_id]
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
      else
        render json: @comment
      end
    end

  # POST /comments
  def create
    if user_signed_in?
      user_id = current_user.id
      @comment = Comment.new(comment_params)
      if @comment.save
        render json: @comment, status: :created, location: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /comments/1
  def update
    if current_user.id == @comment.user_id
      params[:user_id] = current_user.id
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  end

  # DELETE /comments/1
  def destroy
    if current_user.id == @comment.user_id or current_user.security_level == 3
      @comment.destroy
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def comment_params
    params.require(:comment).permit(:content,
                                    :text, :user_id, :article_id, :published_at)
  end
end
