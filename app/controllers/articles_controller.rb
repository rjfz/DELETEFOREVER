# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :add_article_breadcrumbs
  before_action :require_login, except: %i[index show]

  def index
    @articles = Article.all
    breadcrumbs.add 'Article Listing'
  end

  def show
    find_article_id
    @comment_counter_offset = (((params[:page] || 1).to_i - 1) * Comment.per_page) + 1
    @comments = @article.comments.paginate(page: params[:page])
    breadcrumbs.add @article.title
  end

  def new
    @article = Article.new
    breadcrumbs.add 'New Article'
  end

  def edit
    find_article_id
    author_permission
    breadcrumbs.add @article.title, article_path(@article)
    breadcrumbs.add 'Edit'
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

  def find_article_id
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def author_permission
    return if can? :update, @article

    flash[:warning] = 'You are not the author of this article'
    redirect_to '/articles'
  end

  def add_article_breadcrumbs
    breadcrumbs.add 'Articles', articles_path
  end
end
