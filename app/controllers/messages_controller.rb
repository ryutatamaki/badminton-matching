class MessagesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @message = current_user.messages.build(new_message_params)
    if @message.save
      flash[:success] = "コメントしました"
      redirect_to @message.micropost
    else
      @micropost = @message.micropost
      @messages = @micropost.messages.where.not(id: nil)
      @user = @micropost.user
      flash.now[:danger] = "コメントできませんでした"
      render 'microposts/show'
    end
  end
  
  def edit
  end
  
  def update
    if @message.update(edit_message_params)
      flash[:success] = "コメントを編集しました"
      redirect_to @message.micropost
    else
      flash.now[:denger] = "編集できませんでした"
      render 'micropost/show'
    end
  end

  def destroy
    @message.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def new_message_params
    params.require(:message).permit(:micropost_id, :comment)
  end
  
  def edit_message_params
    params.require(:message).permit(:comment)
  end
  
  def correct_user
    @message = current_user.messages.find_by(id: params[:id])
    unless @message
      redirect_back(fallback_location: root_path)
    end
  end
end
