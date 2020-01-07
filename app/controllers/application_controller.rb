class ApplicationController < ActionController::Base
    helper_method :current_user, :right_user

    def current_user
        User.find(session[:user_id])
    end

    def require_login
        return head(:forbidden) unless session.include? :user_id
    end

    def right_user
        if params[:user_id].nil?
            return head(:forbidden) unless current_user.id == params[:id].to_i
        else
            return head(:forbidden) unless current_user.id == params[:user_id].to_i
        end
    end
end
