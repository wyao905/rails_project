class Zookeeper::ExhibitsController < ApplicationController
    def index
        @exhibits = Exhibit.all
        @user = current_user
    end

    def new
        @exhibit = Exhibit.new
        @species = Animal.species
        @user = current_user
        @exhibit.animals.build
    end

    def create
        exhibit = Exhibit.create(exhibit_params(:name, animals_attributes: [:name, :species]))
        if exhibit.save
            redirect_to zookeeper_user_exhibits_path(current_user)
        else
            render :new
        end
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