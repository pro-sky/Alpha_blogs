class PagesController < ApplicationController
  before_action :require_user, only: [:articlestable]
  require 'pdfkit'

  def home
    redirect_to articles_path if logged_in?
  end

  def about
  end

  def articlestable
    @articles = Article.paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.pdf do
        html = render_to_string(layout: false, action: "articlestable.html.erb")
        pdf = PDFKit.new(html)
        send_data pdf.to_pdf, filename: "articles.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end


  private

  def require_user
    if !logged_in?
      flash[:alert] =" You must be signed in"
      redirect_to login_path
    end
  end
end
