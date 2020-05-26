class TeachMessagesController < ApplicationController
  def create
    teach_message.create(teach_message_params)
    redirect_to root_path
  end
end

private
def teach_message_params
  params.require(:teach_message).permit(:comment, :image).merge(user_id: current_user.id)
end