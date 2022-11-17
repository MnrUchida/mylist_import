module Shared
  class ActorsController < ApplicationController
    before_action :set_actor, only: %i[update destroy]

    def index
      @actors = Actor.all
      @actors = @actors.where("name LIKE :name", name: "%#{search_params[:name]}%")
      @actors = @actors.page(params[:page])
    end

    def new
      @actor = Actor.new
    end

    def create
      @actor = Actor.new(actor_params)
      render :new, status: :unprocessable_entity unless @actor.save
    end

    def update; end

    def destroy; end

    private def actor_params
      params.require(:actor).permit(:name, :url)
    end

    private def search_params
      params.fetch(:search, {}).permit(:name)
    end

    private def set_actor
      @actor = Actor.find(params[:id])
    end
  end
end
