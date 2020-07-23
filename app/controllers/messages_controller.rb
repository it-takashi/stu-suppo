class MessagesController < ApplicationController
  before_action :set_callroom2

  def create
    @message = @callroom.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.json
      end
    else
      @messages = @callroom.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render template: 'teach/show', layout: 'show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:comment, :image).merge(user_id: current_user.id)
  end

  def set_callroom2
    @callroom = Callroom.find(params[:callroom_id])
  end
end
