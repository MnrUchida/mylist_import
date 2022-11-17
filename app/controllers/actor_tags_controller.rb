class ActorTagsController < ApplicationController
  def index
    @actors = if params[:only]
                ActorTag.only_not_used.order(actor_tag_articles_count: :desc).page(params[:page]).per(200)
              else
                ActorTag.order(actor_tag_articles_count: :desc).page(params[:page])
              end
  end

  def show
    @actor = ActorTag.find(params[:id])
    @articles = ArticleDecorator.decorate_collection(@actor.articles.page(params[:page]))
  end
end
