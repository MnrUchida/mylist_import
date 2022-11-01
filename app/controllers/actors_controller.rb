class ActorsController < ApplicationController
  def index
    @actors = ActorTag.order(actor_tag_articles_count: :desc).page(params[:page])
  end

  def show
    @actor = ActorTag.find(params[:id])
    @articles = ArticleDecorator.decorate_collection(@actor.articles.page(params[:page]))
  end
end
