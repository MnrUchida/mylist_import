class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @articles = Article.default_order.page(params[:page])
  end

  # GET /articles/1 or /articles/1.json
  def show
    @decorated_article = ArticleDecorator.decorate(@article)
  end

  # GET /articles/1/edit
  def edit
  end

  def new
    @article = Article.new
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    @article.attributes = article_params
    respond_to do |format|
      if @article.save_with_actors!(article_params[:actor_ids])
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save_with_actors!(article_params[:actor_ids])
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:note, :title, :url, :common_tag_list, :actor_list, :music_id, actor_ids: [])
    end
end
