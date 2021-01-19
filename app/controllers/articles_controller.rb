# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :require_login, except: %i[index show]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @comment_counter_offset = (((params[:page] || 1).to_i - 1) * Comment.per_page) + 1
    @comments = @article.comments.paginate(page: params[:page])
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
    author_permission
  end

  def create
    @article = Article.new(author_id: current_user.id, **article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def author_permission
    return if can? :update, @article

    flash[:warning] = 'You are not the author of this article'
    redirect_to '/articles'
  end
end
