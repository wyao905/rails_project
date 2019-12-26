class Zookeeper::AnimalsController < ApplicationController
    def index
        @exhibits = Exhibit.all.sort_by{|a| [a.name]}
        @user = current_user
    end

    def create
        @exhibit = Exhibit.find(params[:animal][:exhibit_id])
        @user = current_user
        if @exhibit.funds >= 200
            animal = @exhibit.animals.build(animal_params(:name, :species))

            animal.update(hunger: rand(-2..2))
            animal.update(sick: animal.health)

            if animal.save
                @exhibit.update(funds: @exhibit.funds -= 200)
                redirect_to zookeeper_user_exhibit_path(@user, @exhibit)
            else
                @animal = Animal.new
                flash[:message] = "Please enter valid name and species."
                render "zookeeper/exhibits/edit"
            end
        else
            @animal = Animal.new
            flash[:message] = "Not enough funds."
            render "zookeeper/exhibits/edit"
        end
    end

    def show
        @animal = Animal.find(params[:id])
        @user = current_user
    end

    def edit
        @animal = Animal.find(params[:id])
    end

    def update
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