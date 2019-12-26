class AnimalsController < ApplicationController
    def index
        @exhibits = Exhibit.all.sort_by{|a| [a.name]}
    end

    def show
        @animal = Animal.find(params[:id])
    end
end