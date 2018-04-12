class SessionsController < ApplicationController
  
  include SessionsHelper
  
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = "ログインしました"
      redirect_to @user
    else
      flash[:danger] = "ログインに失敗しました"
      render :new
    end 
  end

  def destroy
    session[:user_id] = nil
    flash.now[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  
  
  
  
  
end
