class CommentsController < ApplicationController
  # before_action :authenticate_user!, only: [:create,:destroy]
  before_action :require_user
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @article, notice: "Comment was successfully created."
    else
      redirect_to @article, alert: "Comment could not be created."
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    if @comment.user == current_user || current_user.admin?
      @comment.destroy
      redirect_to @article, notice: "Comment was successfully deleted."
    else
      redirect_to @article, alert: "You are not authorized to delete this comment."
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
