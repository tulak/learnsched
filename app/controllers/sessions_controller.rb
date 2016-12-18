class SessionsController < ApplicationController
  skip_before_action :authenticate!
  layout 'login'

  def login_form
    @login_form = LoginForm.new
  end

  def login
    @login_form = LoginForm.new login_params
    if @login_form.login
      session[:user_id] = @login_form.logged_user.id
      redirect_to root_path
    else
      render action: 'login_form'
    end
  end

  def logout
    reset_session
    redirect_to root_path

  end

  def register_form
    @register_form = RegisterForm.new
  end

  def register
    @register_form = RegisterForm.new register_params
    if @register_form.register
      session[:user_id] = @register_form.registered_user.id
      redirect_to profile_users_path
    else
      render action: 'register_form'
    end
  end
  
  private
  def login_params
    params.require(:login_form).permit(:email, :password)
  end

  def register_params
    params.require(:register_form).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
