class Zookeeper::ActionsController < ApplicationController
    def index
        @animal = Animal.find(params[:animal_id])
        @actions = Action.all.select{|a| a.animal_id == @animal.id}
    end

    def create
        action = current_user.actions.build(action_params(:action_type, :animal_id))
        animal = Animal.find(params[:animal_id])
        if params[:action_type] == "Feed"
            if animal.hunger == "2"
                flash[:message] = "#{animal.name} is too full to eat anymore."
            else
                action.save
                animal.update(hunger: animal.hunger.to_i + 1)
            end
        else
            if animal.sick
                action.save
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