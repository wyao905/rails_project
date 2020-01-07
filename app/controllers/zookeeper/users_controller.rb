class Zookeeper::UsersController < ApplicationController
    before_action :require_login
    before_action :right_user

    def show
        @user = current_user
    end

    def create
        current_user.update(zookeeper: true)
        redirect_to zookeeper_user_path(current_user)
    end

    def edit
        @user = current_user
    end

    def update
        user = User.find(params[:id])
        user.update(user_params(:username, :password))
        redirect_to zookeeper_user_path(user)
    end

    private

    def user_params(*args)
        params.require(:user).permit(*args)
    end
end