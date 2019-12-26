class UsersController < ApplicationController
    helper_method :current_user

    def index
    end

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
    end

    def update
    end

    private

    def user_params(*args)
        params.require(:user).permit(*args)
    end
end