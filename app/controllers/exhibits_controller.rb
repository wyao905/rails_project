class ExhibitsController < ApplicationController
    def index
        @exhibits = Exhibit.all
    end

    def new
    end

    def create
    end

    def show
        @exhibit = Exhibit.find(params[:id])
        @user = current_user
    end

    def edit
    end

    def update
    end

    def delete
    end

    def claim
    end

    private

    def user_params(*args)
        params.require(:user).permit(*args)
    end

    def current_user
        User.find(session[:user_id])
    end
end