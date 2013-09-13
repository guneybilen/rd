class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user

    if user.nil?
      flash[:notice] = "No user has been found with that email address"
    else
      flash[:notice] = "An email is sent to your email address to reset your password"
    end

    redirect_to root_url
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])

    if params[:user][:password].blank?
      #@user.errors.add('', 'Password cannot be blank')
      flash[:error] = 'Password cannot be blank'
      render :action => 'edit'
    elsif @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => 'The email sent in order to reset your password is expired'
    elsif @user.update_attributes(params[:user])
      sign_in(@user)
      redirect_to root_url, :notice => 'Your password has been reset!'
    else
      if @user.errors.any?
        @user.errors.full_messages.each do |msg|
          flash.now[:error] = "#{msg}"
        end
      end
      render :edit
    end
  end

end
