class Zookeeper::AnimalsController < ApplicationController
    before_action :require_login
    before_action :right_user

    def index
        @exhibits = Exhibit.all.sort_by{|a| [a.name]}
        @user = current_user
    end

    def create
        exhibit = Exhibit.find(params[:animal][:exhibit_id])
        @user = current_user

        if exhibit.funds >= 200
            @animal = exhibit.animals.build(animal_params(:name, :species))
            @animal.assign_attributes(hunger: rand(-2..2))
            @animal.assign_attributes(sick: @animal.health)

            if @animal.save
                @exhibit = exhibit
                @exhibit.update(funds: @exhibit.funds -= 200)
                redirect_to zookeeper_user_exhibit_path(@user, @exhibit)
            else
                @exhibit = Exhibit.find(params[:animal][:exhibit_id])
                render "zookeeper/exhibits/edit"
            end
        else
            @animal = Animal.new
            @exhibit = exhibit
            flash.now[:message] = "Not enough funds."
            render "zookeeper/exhibits/edit"
        end
    end

    def show
        @animal = Animal.find(params[:id])
        @user = current_user
    end

    def edit
        @animal = Animal.find(params[:id])
        @user = current_user
    end

    def update
        @animal = Animal.find(params[:id])
        @user = current_user
        if @animal.update(animal_params(:name))
            redirect_to zookeeper_user_animal_path(current_user, @animal)
        else
            render :edit
        end
    end

    def destroy
        animal = Animal.find(params[:id])
        animal.actions.each do |action|
            action.delete
        end
        animal.delete
        redirect_to zookeeper_user_exhibit_path(current_user, animal.exhibit)
    end

    private

    def animal_params(*args)
        params.require(:animal).permit(*args)
    end
end