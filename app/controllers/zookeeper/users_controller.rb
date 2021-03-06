class Zookeeper::UsersController < ApplicationController
    before_action :require_login, :right_user
    skip_before_action :right_user, only: [:create]

    def show
        @user = current_user
    end

    def create
        user = current_user
        if user.donation_status == "Platinum"
            user.update(zookeeper: true)
            flash[:message] = "You are now a zookeeper!"
            redirect_to zookeeper_user_path(current_user)
        else
            flash[:message] = "Sorry, your donation level must be 'Platinum' to be a zookeeper."
            redirect_to user_path(@user)
        end        
    end

    def edit
        @user = current_user
    end

    def update
        @user = User.find(params[:id])
        @user.update(username: params[:user][:username]) if !params[:user][:username].empty?
        @user.update(password: params[:user][:password]) if !params[:user][:password].empty?
        redirect_to zookeeper_user_path(@user)
    end

    private

    def user_params(*args)
        params.require(:user).permit(*args)
    end
end