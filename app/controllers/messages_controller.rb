class MessagesController < ApplicationController
  before_action :set_teach

  def create
    @message = @teach.messages.new(message_params)
    if @message.save
      redirect_to teach_messages_path(@teach), notice: 'メッセージが送信されました'
    else
      @messages = @teach.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :"teach/show"
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Teach.find(params[:teach_id])
  end
end
