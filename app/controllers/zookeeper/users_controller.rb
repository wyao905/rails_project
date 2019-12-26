class Zookeeper::UsersController < ApplicationController
    def show
        @user = current_user
    end

    def create
        current_user.update(zookeeper: true)
        redirect_to zookeeper_user_path(current_user)
    end

    private

    def user_params(*args)
        params.require(:user).permit(*args)
    end
end