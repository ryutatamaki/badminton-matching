class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    if logged_in?
      @user = current_user
      @micropost = current_user.microposts.build
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page])
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_paramas)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました'
      redirect_to microposts_path
    else
      @microposts = current_user.feed_microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = "投稿できませんでした"
      render :index
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def micropost_paramas
    params.require(:micropost).permit(:content)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to microposts_path
    end
  end
end
