class UsersController < ApplicationController
    before_action :require_login
    before_action :right_user
    skip_before_action :require_login, only: [:new, :create]
    skip_before_action :right_user, only: [:new, :create]

    def show
        @user = current_user
        @user.donations.build
    end

    def new
        @user = User.new
        render layout: false
    end

    def create
        @user = User.create(user_params(:username, :balance, :password))
        if !@user.password.nil? && @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            render :new, layout: false
        end
    end

    def edit
        @user = current_user
    end

    def update
        @user = User.find(params[:id])
        @user.assign_attributes(username: params[:user][:username]) if !params[:user][:username].empty?
        @user.assign_attributes(password: params[:user][:password]) if !params[:user][:password].empty?
        if !params[:user][:balance].scan(/\D/).empty? && !params[:user][:balance].empty?
            flash.now[:message] = "Balance must be in dollars"
            render :edit
        else
            @user.assign_attributes(balance: @user.balance.to_i + params[:user][:balance].to_i)
            @user.save(validate: false)
            redirect_to user_path(@user)
        end
    end

    private

    def user_params(*args)
        params.require(:user).permit(*args)
    end
end