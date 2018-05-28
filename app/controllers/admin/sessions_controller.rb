class Admin::SessionsController < Admin::ApplicationController
    layout 'admin/login'
  def new
  end

  def create
    user = User.authenticate(params[:email],params[:password])
    if user
      session[:user_id] = user.id
      redirect_to admin_posts_path, :notice => "Logged In"
    else
      flash.now.alert = "Invalid Email Or Password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_login_path, :notice => "Logged Out"
  end
end
