class SessionsController < ApplicationController

    def new
    end

    def create
        # debugger
        user = User.find_by(email: params[:sessions][:email].downcase)
        if user && user.authenticate(params[:sessions][:password])
            session[:user_id] = user.id
            flash[:success] = "You have Successfully Logged In"
            redirect_to user_path(user)
        else
            flash.now[:danger] = "Either Email or Password is Incorrect"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:success] = "You are Successfully Logged out"
        redirect_to root_path
    end

end