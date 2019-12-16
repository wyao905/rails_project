class DonationsController < ApplicationController
    def index
        @user = current_user
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

            redirect_to user_path(current_user)
        else
            render "users/show"
        end
    end

    def edit
        @donation = Donation.find(params[:id])
    end

    def update
        # if valid do below, else render
        donation = Donation.find(params[:id])
        donation.update(message: params[:donation][:message])
        redirect_to user_donations_path(current_user)
    end

    private

    def donation_params(*args)
        params.require(:donation).permit(*args)
    end

    def current_user
        User.find(session[:user_id])
    end
end