class Zookeeper::ActionsController < ApplicationController
    def create
        current_user.action.build(action_params(:action_type, :animal_id))
        binding.pry
        animal = Animal.find(params[:animal_id])
        if params[:action_type] == "Feed"
            animal.update(hunger: animal.hunger.to_i + 1) 
        else
            animal.update(sick: false)
        end
        redirect_to zookeeper_user_exhibit_path(current_user, animal.exhibit)
    end

    private

    def action_params(*args)
        params.permit(*args)
    end

    def current_user
        User.find(session[:user_id])
    end
end