class UsersController < ApplicationController
    helper_method :current_user

    def index
    end

    def show
    end

    def new
        binding.pry
        @user = User.new
    end

    def create
        user = User.create(user_params[:username, :balance, :zookeeper, :password])
        binding.pry
    end

    def edit
    end

    def update
    end

    private

    def user_params(*args)
        params.require(:user).permit(*args)
    end

    def current_user
        User.find(session[:user_id])
    end
end