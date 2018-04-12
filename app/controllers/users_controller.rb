class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  include SessionsHelper
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user.email, @user.password)
      flash[:success] = 'ユーザーを登録しました'
      redirect_to @user
    else 
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :address, :password, :password_confirmation)
  end
end
