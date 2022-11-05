class MusicTagsController < ApplicationController
  def index
    @musics = if params[:only]
      MusicTag.where.missing(:music_tag_musics).order(:name).page(params[:page]).per(200)
    else
      MusicTag.order(music_tag_articles_count: :desc).page(params[:page])
    end
  end

  def show
    @music = MusicTag.find(params[:id])
    @articles = ArticleDecorator.decorate_collection(@music.articles.page(params[:page]))
  end
end
