class SessionsController < ApplicationController

  def new
    if params[:going_for_root] == 'yes'
        session[:going_for_root] = 'yes'
    end
  end

  def create
     user = User.find_by_email(params[:session][:email].downcase)
     if user && user.authenticate(params[:session][:password])
       sign_in user
       if session[:going_for_root] == 'yes'
         session[:going_for_root] = nil
         redirect_to root_path and return
       end
       redirect_back_or user
     else
       flash.now[:error] = 'Invalid email/password combination' # Not quite right!
       render 'new'
     end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
