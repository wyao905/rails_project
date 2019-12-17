class ExhibitsController < ApplicationController
    def index
        @exhibits = Exhibit.all
    end

    def new
    end

    def create
    end

    def show
        @exhibit = Exhibit.find(params[:id])
    end

    def edit
    end

    def update
    end

    def delete
    end

    def claim
    end
end