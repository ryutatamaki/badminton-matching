class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    if logged_in?
      @user = current_user
      @micropost = current_user.microposts.build
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page])
    end
  end
  
  def show
    @micropost = Micropost.find(params[:id])
    @message = @micropost.messages.build
    @messages = @micropost.messages.where.not(id: nil)
    @user = @micropost.user
    count_comments(@micropost)
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = '投稿しました'
      redirect_to microposts_path
    else
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = "投稿できませんでした"
      render :index
    end
  end
  
  def edit

  end
  
  def update
    if @micropost.update(micropost_params)
      flash[:success] = "投稿を編集しました"
      redirect_to microposts_path
    else
      flash.now[:danger] = "投稿を編集できませんでした"
      render :index
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def comments
    @micropost = Micropost.find(params[:id])
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to microposts_path
    end
  end
  
  
end
