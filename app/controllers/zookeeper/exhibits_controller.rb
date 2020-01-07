class Zookeeper::ExhibitsController < ApplicationController
    before_action :require_login
    before_action :right_user

    def index
        @exhibits = Exhibit.all
        @user = current_user
    end

    def new
        @exhibit = Exhibit.new
        @species = Animal.species
        @user = current_user
        @animal = @exhibit.animals.build
    end

    def create
        @user = current_user
        @exhibit = Exhibit.create(exhibit_params(:name, animals_attributes: [:name, :species]))

        if @exhibit.save
            redirect_to zookeeper_user_exhibits_path(@user)
        else
            render :new
        end
    end

    def show
        @exhibit = Exhibit.find(params[:id])
        @user = current_user
    end

    def edit
        @exhibit = Exhibit.find(params[:id])
        @user = current_user
        @animal = Animal.new
    end

    def update
        @exhibit = Exhibit.find(params[:id])
        @user = current_user
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