class MessagesController < ApplicationController
  before_action :set_teach

  def create
    @message = @teach.messages.new(message_params)
    if @message.save
      redirect_to teach_path(@teach), notice: 'メッセージが送信されました'
    else
      @messages = @teach.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      redirect_to teach_path(@teach)
    end
  end

  private

  def message_params
    params.require(:message).permit(:comment, :image).merge(user_id: current_user.id)
  end

  def set_teach
    @teach = Teach.find(params[:teach_id])
  end
end
