class UsersController < ApplicationController

    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    before_action :reqire_admin, only: [:destroy]

    def new
        @user = User.new
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 5)
    end

    def show
        @user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
            redirect_to user_path(@user)
        else
            render 'new'
        end
    end

    def edit 
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Your Account Updated Successfully."
            redirect_to articles_path
        else
            render 'edit'
        end
    end

    def destroy
        @user.destroy
        flash[:danger] = "User and All Artciles created by User have been Deleted."
        redirect_to users_path
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user

        if current_user != @user and !current_user.admin?
          flash[:danger] = "You can only edit your own Account."
          redirect_to root_path
        end
        
    end

    def reqire_admin
        if logged_in? and !current_user.admin?
            flash[:danger] = "Only Admin User can perform this Action"
            redirect_to root_path
        end
    end
 

end