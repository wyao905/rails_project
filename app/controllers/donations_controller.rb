class DonationsController < ApplicationController
    def index
    end

    def new
    end

    def create
        donation = current_user.donations.build(donation_params(:amount, :message, :exhibit_id))
        if donation.save
            new_balance = current_user.balance - donation.amount
            new_fund = donation.exhibit.funds + donation.amount
            current_user.update(balance: new_balance)
            donation.exhibit.update(funds: new_fund)
            binding.pry
            redirect_to user_path(current_user)
        else
            render "users/show"
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def donation_params(*args)
        params.require(:donation).permit(*args)
    end

    def current_user
        User.find(session[:user_id])
    end
end