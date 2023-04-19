class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show] #filters functions
    before_action :require_same_user, only: [:edit, :update, :destroy] # filters
    before_action :require_admin, only: [:destroy] #filters
    before_action :authenticate_user!
    def index
        @users = User.all
    end
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to the alpha blog #{@user.username}"
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end
    
    def edit
    end
    def update
        if @user.update
            flash[:success] = "Your account was updated successfully"
            redirect_to articles_path
        else
            render 'edit'
        end
    end
    def show
        @user_articles = @user.articles
    end
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:danger] = "User and all articles created by user have been deleted"
        redirect_to user_path
    end
    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
    def set_user
        @user = User.find(params[:id])
    end
    def require_same_user
        if current_user != @user and !current_user.admin?
            flash[:danger] = "You can edit your own account"
            redirect_to root_path
        end
    end
    def require_admin
        # if logged_in? and !current_user.admin?
        #     flash[:danger] = "Only admin users can perform that action"
        #     redirect_to root_path
        # end
        return true
    end
  end
  
  