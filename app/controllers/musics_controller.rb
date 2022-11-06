class MusicsController < ApplicationController
  before_action :set_music, only: %i[show edit update destroy]

  def index
    @musics = Music.all
    @musics = @musics.where("title LIKE :title", title: "%#{search_params[:title]}%")
    @musics = @musics.page(params[:page])
  end

  def new
    @music = Music.new(title: params[:title], tag_ids: params[:tag_ids])
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @music.update(music_params)
        format.html { redirect_to music_url(@music), notice: "Music was successfully updated." }
        format.json { render :show, status: :ok, location: @music }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @music = Music.new(music_params)
    respond_to do |format|
      if @music.save
        format.html { redirect_to music_url(@music), notice: "Music was successfully updated." }
        format.json { render :show, status: :ok, location: @music }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_music
      @music = Music.find(params[:id])
    end

    def music_params
      params.require(:music).permit(:note, :title, :url, :tag_ids)
    end

    def search_params
      params.fetch(:search, {}).permit(:title)
    end
end
