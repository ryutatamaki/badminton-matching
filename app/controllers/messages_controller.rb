class MessagesController < ApplicationController
  before_action :require_user_logged_in
  

  def create
    @message = current_user.messages.build(new_message_params)
    if @message.save
      flash[:success] = "メッセージを保存しました"
      redirect_to @message.micropost
    else
      @micropost = @message.micropost
      @messages = @micropost.messages.where.not(id: nil)
      flash.now[:danger] = "メッセージの保存に失敗しました。"
      render 'microposts/show'
    end
  end

  def destroy
  end
  
  private
  
  def new_message_params
    params.require(:message).permit(:micropost_id, :comment)
  end
  
  def edit_message_params
    params.require(:message).permit(:comment)
  end
end
