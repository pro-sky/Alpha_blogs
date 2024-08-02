class ArticlesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper
  before_action :authenticate_user!, only: [:index,:edit,:update,:destroy,:show]
  # load_and_authorize_resource
  before_action :set_article, only: [:show, :edit, :update, :destroy, :download]
  before_action :set_user_reaction, except: [:show, :index]
  before_action :set_user_reaction, only: [:show]

  # before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
      # @article = Article.find(params[:id])
      @article.increment!(:view_count)
  end

  def index
      @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
      @article = Article.new

  end

  def edit
      # @article = Article.find(params[:id])
  end



  def create

      @article = Article.new(article_params)
      @article.user = current_user
      if @article.save
        #   NotifyWorker.perform_async(@article.id)  if @article.persisted?
          ArticleMailer.new_post_notification(@article.id).deliver_now if @article.persisted?
          flash[:notice] = "Article was created successfully"
          redirect_to @article
      else
          render 'new'
      end
  end

  def update
      # @article = Article.find(params[:id])
    if   @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
      # @article = Article.find(params[:id])
      flash[:notice] = "Article deleted successfully"
      @article.destroy
      redirect_to articles_path

  end

  def external
      @external_articles = ExternalArticlesService.fetch_articles
  end


  def download
    respond_to do |format|
      format.pdf do
          pdf = Prawn::Document.new

          pdf.define_grid(columns: 5, rows: 8, gutter: 10)
          pdf.grid([0, 0], [1, 4]).bounding_box do
              pdf.text @article.title, size: 20, style: :bold, align: :center
              pdf.move_down 20
          end
          # pdf.grid([1,2], [0, 20]).bounding_box do
          #   pdf.text "by " + @article.user.username, size: 8, style: :bold, align: :left
          #   pdf.move_down 10
          # end
          pdf.grid([2, 0], [7, 4]).bounding_box do
          pdf.text strip_tags(@article.discription), size: 12, align: :justify
          end
          if params[:preview].present?
          send_data pdf.render, filename: 'post.pdf', type: 'application/pdf', disposition: 'inline'
          else
          send_data pdf.render, filename: 'post.pdf', type: 'application/pdf', disposition: 'attachment'
          end
      end
    end
  end




  private

  def set_article
  @article = Article.find(params[:id])
  end

  def set_user_reaction
    @user_reaction = @article.reactions.find_by(user: current_user)
  end

  def article_params
      params.require(:article).permit(:title, :discription,category_ids:[ ])
  end

  def require_same_user
      if current_user != @article.user && !current_user.admin?
      flash[:alert]="You can only edit and update your own article"
      redirect_to @article
      end
  end

  def authenticate_user!
      unless current_user
      flash[:alert] = "You must be signed in to access this page."
      redirect_to login_path
      end
  end
end
