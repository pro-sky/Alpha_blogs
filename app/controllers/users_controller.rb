class UsersController < ApplicationController
    # load_and_authorize_resource
    before_action :authenticate_user!, only: [:index,:edit,:update,:destroy,:show]
    # before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :require_user, only: [:edit, :update]
    before_action :authorize_admin!, only: [:userlist]
    before_action :set_user, only: [:show, :edit, :update, :destroy]
   
    def show
        @articles= @user.articles.paginate(page: params[:page], per_page: 3)
    end
    
    def index
        @users = User.paginate(page: params[:page], per_page: 3)
    end

    def userlist
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def new 
        @user = User.new
    end

    def edit
       
    end

    def update
       
        if @user.update(user_params)
            flash[:notice] = "Your account information was successfully updated"
            redirect_to user_path

        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice]= "Wecome to My-blog #{@user.username},You have successfully signed in"
            redirect_to users_path
        else
            render 'new'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user == current_user
        flash[:notice] = "Account and its associated article are deleted successfully"
        redirect_to articles_path

    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        if current_user != User.find(params[:id]) && !current_user.admin?
        flash[:alert]="You can only edit and delete your own account"
        redirect_to users_path
        end
    end

    def authenticate_user!
          unless current_user
          flash[:alert] = "You must be signed in to access this page."
          redirect_to login_path
          end
        end
    
        def authorize_admin!
            unless current_user.admin?
              flash[:alert] = "You are not authorized to view this page,only admin can view this."
              redirect_to root_path
              # or you might want to render a 403 forbidden status
              # render file: "#{Rails.root}/public/403.html", status: :forbidden
            end
          end

end