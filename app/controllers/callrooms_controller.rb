class CallroomsController < ApplicationController
  def new
    @callroom = Callroom.new
  end

  def create
    @callroom =  Callroom.create(callroom_params)
    redirect_to callroom_path(@callroom.id)
  end

  def show
    @callroom = Callroom.find(params[:id])
      # 公開がtureで生徒がいるときは、先生と生徒しか入ることができない
    if @callroom.release.present? && @callroom.student_id.present?
      if @callroom.user_id == current_user.id or @callroom.student_id ==  current_user.id
      else
      redirect_to root_path
      end
      #非公開　releaseが0の場合生徒は入ることができない
    elsif @callroom.release == false
      unless @callroom.user_id == current_user.id
        redirect_to root_path
      end
      # 生徒がいないときは、studentに生徒を登録する
    else @callroom.student_id.nil?
      unless @callroom.user_id == current_user.id
        @callroom.student_id = current_user.id
        @callroom.save
      end
    end
    # @id = @callroom.id
    # @message = Message.new
    # @messages = @callroom.messages.includes(:user)
  end

  def edit
    # 教えるモードでは、editページへ
    @callroom = Callroom.find(params[:id])
  end

  def update
    @callroom = Callroom.find(params[:id])
    @callroom.update(callroom_params)
    redirect_to callroom_path(@callroom.id)
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