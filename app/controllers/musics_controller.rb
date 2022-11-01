class MusicsController < ApplicationController
  def index
    @musics = MusicTag.order(music_tag_articles_count: :desc).page(params[:page])
  end

  def show
    @music = MusicTag.find(params[:id])
    @articles = ArticleDecorator.decorate_collection(@music.articles.page(params[:page]))
  end

  def update
    @music = MusicTag.find(params[:id])
    debugger
    @music.update!(music_tag_articles_count: @music.music_tag_articles.count)
    redirect_to action: :show
  end
end
