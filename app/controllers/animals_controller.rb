class AnimalsController < ApplicationController
    before_action :require_login
    
    def index
        @exhibits = Exhibit.all.sort_by{|a| [a.name]}
    end

    def show
        @animal = Animal.find(params[:id])
    end
end