# frozen_string_literal: true

module FindArticle
  def find_article
    @article = Article.find(params[:article_id])
  end
end
