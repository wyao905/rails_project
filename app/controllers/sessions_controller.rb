class SessionsController < ApplicationController
    def new
        render layout: false
    end

    def create
        @user = User.find_by(username: params[:username])
        if @user.nil?
            flash.now[:message] = "Incorrect/Missing Username"
            render :new, layout: false
        else
            if !@user.authenticate(params[:password])
                flash.now[:message] = "Incorrect Password"
                render :new, layout: false
            else
                session[:user_id] = @user.id
                if @user.zookeeper
                    redirect_to "/zookeeper/users/#{@user.id}"
                else
                    redirect_to "/users/#{@user.id}"
                end
            end
        end
    end

    def create_google
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.username = auth['info']['name']
            u.password = auth['uid']
            u.balance = 0
        end
        if @user.save
            session[:user_id] = @user.id
            if @user.zookeeper
                render "/zookeeper/users/#{@user.id}"
            else
                redirect_to "/users/#{@user.id}"
            end
        else
            flash[:message] = "Could not login with Google+"
            redirect_to '/'
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end

    private
    
    def auth
        request.env['omniauth.auth']
    end
end