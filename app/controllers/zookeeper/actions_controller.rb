class Zookeeper::ActionsController < ApplicationController
    def index
        binding.pry
        @animal = Animal.find(params[:animal_id])
    end

    def create
        action = current_user.actions.build(action_params(:action_type, :animal_id))
        action.save
        animal = Animal.find(params[:animal_id])
        if params[:action_type] == "Feed"
            if animal.hunger == "2"
                flash[:message] = "#{animal.name} is too full to eat anymore."
            else
                animal.update(hunger: animal.hunger.to_i + 1)
            end
        else
            if animal.sick
                animal.update(sick: false)
            else
                flash[:message] = "#{animal.name} does not appear to be sick."
            end
        end
        redirect_to zookeeper_user_animal_path(current_user, animal)
    end

    private

    def action_params(*args)
        params.permit(*args)
    end

    def current_user
        User.find(session[:user_id])
    end
end