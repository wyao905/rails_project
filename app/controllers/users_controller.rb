class UsersController < ApplicationController
    def show
        @user = current_user
        @user.donations.build
    end

    def new
        render layout: false
    end

    def create
        user = User.create(user_params(:username, :balance, :password))
        if user.save
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            render :new
        end
    end

    def edit
        @user = current_user
    end

    def update
        user = User.find(params[:id])
        user.update(username: params[:user][:username], balance: user.balance.to_i + params[:user][:balance].to_i)
        redirect_to user_path(user)
    end

    private

    def user_params(*args)
        params.require(:user).permit(*args)
    end
end