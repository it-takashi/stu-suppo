class MessagesController < ApplicationController
  before_action :set_teach

  def create
    @message = @teach.messages.new(message_params)
    if @message.save
      respond_to do |format|
        format.json
      end
    else
      @messages = @teach.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render template: 'teach/show', layout: 'show'
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
