class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username: params[:username])
        if user.nil?
            flash[:message] = "Incorrect Username"
            render :new
        else
            if !user.authenticate(params[:password])
                flash[:message] = "Incorrect Password"
                render :new
            else
                session[:user_id] = user.id
                if user.zookeeper
                    redirect_to "/zookeeper/users/#{user.id}"
                else
                    redirect_to "/users/#{user.id}"
                end
            end
        end
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end
end