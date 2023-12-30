class UsersController < ApplicationController
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :set_user, only: [:show, :edit, :update, :destroy]
   
    def show
        @articles= @user.articles.paginate(page: params[:page], per_page: 3)
    end
    
    def index
        @users = User.paginate(page: params[:page], per_page: 3)
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


end