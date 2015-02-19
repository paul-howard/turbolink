class SessionsController < ApplicationController

  def new
    p "Calling 'sessions#new'"
  end

  def create
    @user = User.authenticate(params[:user][:email], params[:user][:password])
    if @user
      session[:user_id] = @user.id
      flash[:success] = 'User logged in!'
      redirect_to root_path
    else
      flash[:error] = 'Nope.'
      render :new
    end
  end

  def destroy
      reset_session
      flash[:success] = 'User logged out.'
      redirect_to login_path
  end

end
