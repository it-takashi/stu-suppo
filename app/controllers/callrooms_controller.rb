class CallroomsController < ApplicationController
  def new
    @callroom = Callroom.new
  end

  def create
    @callroom =  Callroom.create(callroom_params)
    redirect_to root_path
  end

  def show
    @callroom = Callroom.find(params[:id])
    # @id = @callroom.id
    # @message = Message.new
    # @messages = @callroom.messages.includes(:user)
  end

  def edit
    @callroom = Callroom.find(params[:id])
  end

  def update
    @callroom = Callroom.find(params[:id])
    @callroom.update(callroom_params)
    redirect_to root_path
  end

  def destroy
    @callroom = Callroom.find(params[:id])
    @callroom.destroy
    redirect_to root_path
  end

  def update_attribute
    callroom = Callroom.find_by(user_id:current_user.id)
    callroom.release = false
    callroom.save
    redirect_to root_path  
  end

end

private
def callroom_params
  params.require(:callroom).permit(:title, :body, :image,:release).merge(user_id: current_user.id)
end