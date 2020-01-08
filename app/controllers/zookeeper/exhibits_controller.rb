class Zookeeper::ExhibitsController < ApplicationController
    before_action :require_login, :right_user, :inst_user

    def index
        @exhibits = Exhibit.all
    end

    def new
        @exhibit = Exhibit.new
        @species = Animal.species
        @animal = @exhibit.animals.build
    end

    def create
        @exhibit = Exhibit.create(exhibit_params(:name, animals_attributes: [:name, :species]))

        if @exhibit.save
            redirect_to zookeeper_user_exhibits_path(@user)
        else
            render :new
        end
    end

    def show
        @exhibit = Exhibit.find(params[:id])
    end

    def edit
        @exhibit = Exhibit.find(params[:id])
        @animal = Animal.new
    end

    def update
        @exhibit = Exhibit.find(params[:id])
        if @exhibit.update(exhibit_params(:name))
            redirect_to zookeeper_user_exhibit_path(@user, exhibit)
        else
            @animal = Animal.new
            render :edit
        end
    end

    private

    def exhibit_params(*args)
        params.require(:exhibit).permit(*args)
    end
end