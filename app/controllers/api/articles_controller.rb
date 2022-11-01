module Api
  class ArticlesController < ApplicationController
    protect_from_forgery

    def create
      Article.create_from_html(url: article_params[:url], body: article_params[:body])
      render body: nil
    end

    private def article_params
      params.require(:article).permit(:url, :body)
    end
  end
end
