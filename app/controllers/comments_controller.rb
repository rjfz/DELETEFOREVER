# frozen_string_literal: true

class CommentsController < ApplicationController
  include FindArticle

  before_action :find_article, only: %i[create destroy]

  def create
    @comment = @article.comments.create(commenter_id: current_user.id, body: comment_params[:body])
    flash_errors
    redirect_to_article_path
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to_article_path
  end

  private

  def flash_errors
    flash[:error] = list_of_errors(@comment) if @comment.errors.any?
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def redirect_to_article_path
    redirect_to article_path(@article)
  end
end
