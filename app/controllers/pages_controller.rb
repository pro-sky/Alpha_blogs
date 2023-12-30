class PagesController < ApplicationController
    before_action :require_user, only: [:articlestable]
   

    def home 
        redirect_to articles_path if logged_in?
    end

    def about
    end

    def articlestable
       
        @articles = Article.paginate(page: params[:page], per_page: 10)
    end


    private

    def require_user
        if !logged_in?
          flash[:alert] =" You must be signed in"
          redirect_to login_path
        end
      end
end
