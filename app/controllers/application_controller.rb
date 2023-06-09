class ApplicationController < ActionController::Base

    def require_user
        unless user_signed_in?
            flash[:danger] = "You must be logged in to perform that action"
            redirect_to root_path
        end
    end
end