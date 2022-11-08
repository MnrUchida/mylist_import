class ActorsController < ApplicationController
  before_action :set_actor, only: %i[show edit update destroy]

  def index
    # @actors = Actor.preload(:articles)
    # @actors = @actors.where("actors.title LIKE :title", title: "%#{search_params[:title]}%")
    # @actors = @actors.order_by_article_count
    # @actors = @actors.page(params[:page])
    # @actors = ActorDecorator.decorate_collection(@actors)

    @actors = Actor.all
    @actors = @actors.where("actors.name LIKE :name", name: "%#{search_params[:name]}%")
    @actors = @actors.page(params[:page])
  end

  def new
    @actor = Actor.new(name: params[:name], tag_ids: params[:tag_ids])
  end

  def show
    # @actor = ActorDecorator.decorate(@actor, context: { page: params[:page] })
  end

  def edit; end

  def update
    respond_to do |format|
      if @actor.update(actor_params)
        redirect_to actor_url(@actor), notice: "Actor was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def create
    @actor = Actor.new(actor_params)
    respond_to do |format|
      if @actor.save
        redirect_to actor_url(@actor), notice: "Actor was successfully updated."
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  private
    def set_actor
      @actor = Actor.find(params[:id])
    end

    def actor_params
      params.require(:actor).permit(:note, :name, :url, :tag_ids)
    end

    def search_params
      params.fetch(:search, {}).permit(:name)
    end
end
