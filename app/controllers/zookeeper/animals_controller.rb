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
                render "zookeeper/exhibits/show"
            end
        else
            @animal = Animal.new
            render "zookeeper/exhibits/show"
        end
    end

    def show
        @animal = Animal.find(params[:id])
        @user = current_user
    end

    def destroy
        binding.pry
        animal = Animal.find
    end

    private

    def animal_params(*args)
        params.require(:animal).permit(*args)
    end

    def current_user
        User.find(session[:user_id])
    end
end