class DonationsController < ApplicationController
    before_action :require_login
    before_action :right_user

    def index
        @user = current_user
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
        @user = current_user
        @donation = Donation.find(params[:id])
        if @donation.user != @user
            return head(:forbidden)
        end
    end

    def update
        donation = Donation.find(params[:id])
        donation.update(donation_params(:message))
        redirect_to user_donations_path(current_user)
    end

    private

    def donation_params(*args)
        params.require(:donation).permit(*args)
    end
end