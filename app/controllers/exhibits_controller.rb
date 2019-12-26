class ExhibitsController < ApplicationController
    def index
        @exhibits = Exhibit.all
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
end