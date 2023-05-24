class Api::V1::CommentsController < ApplicationController
  before_action :find_comment, only: %i[show update destroy]
  before_action :find_article, only: %i[index create]

  def index
    comments = @article.comments
    render json: comments
  end
  
  def show
    render json: @comment
  end

  def create
    comment = @article.comments.new(comment_params)
    if comment.save
      render json: comment
    else
      render error: { error: "Unable to create comment" }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: { error: "Unable to update comment" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      render json: { message: "Comment successfully deleted" }
    else
      render json: { error: "Unable to delete comment" }
    end
  end

  def search
    comments = Comment.where("lower(comment) LIKE ?", "%#{params[:comment].downcase}%")
    render json: comments
  end

  private
  def find_comment
    @comment = Comment.find(params[:id])
  end

  def find_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
