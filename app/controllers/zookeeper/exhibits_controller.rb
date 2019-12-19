class Zookeeper::ExhibitsController < ApplicationController
    def index
        @exhibits = Exhibit.all
        @user = current_user
    end

    def new
        @exhibit = Exhibit.new
        @species = Animal.species
        @user = current_user
    end

    def create
        binding.pry
    end

    def show
    end

    private

    def exhibit_params(*args)
        params.require(:exhibit).permit(*args)
    end

    def current_user
        User.find(session[:user_id])
    end
end