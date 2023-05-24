class Api::V1::ArticlesController < ApplicationController
  before_action :find_article, only: %i[show update destroy]

  def index
    articles = Article.all.page params[:page]
    render json: articles
  end
  
  def show
    render json: @article
  end

  def create
    article = Article.new(article_params)
    if article.save
      render json: article
    else
      render error: { error: "Unable to create article" }, status: :unprocessable_entity
    end
  end

  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: { error: "Unable to update article" }, status: :unprocessable_entity
    end
  end

  def destroy
    if @article.destroy
      render json: { message: "Article successfully deleted" }
    else
      render json: { error: "Unable to delete article" }
    end
  end

  def search
    articles = Article.where("lower(title) LIKE ?", "%#{params[:title].downcase}%")
    render json: articles
  end
  
  private
  def find_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :release_date)
  end
end
