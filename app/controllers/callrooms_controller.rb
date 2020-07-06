class CallroomsController < ApplicationController
  def new
    @callroom = Callroom.new
  end

  def create
    callroom =  Callroom.create(callroom_params)
    if callroom.release == false
      redirect_to callroom_path(callroom.id),alert: "非公開にしました"
    else
      redirect_to callroom_path(callroom.id),notice: "公開にしました"
    end
  end

  def show
    @callroom = Callroom.find(params[:id])
      # 公開がで生徒がいるときは、先生と生徒しか入ることができない
    if @callroom.release.present? && @callroom.student_id.present?
      if @callroom.user_id == current_user.id or @callroom.student_id ==  current_user.id
        @student = User.find_by(id:@callroom.student_id)
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
        @student = User.find_by(id:@callroom.student_id)


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
    callroom = Callroom.find(params[:id])
    callroom.update(callroom_params)
    if callroom.release == false
      redirect_to callroom_path(callroom.id),alert: "非公開にしました"
    else
      redirect_to callroom_path(callroom.id),notice: "公開にしました"
    end
  end

  def destroy
    @callroom = Callroom.find(params[:id])
    @callroom.destroy
    redirect_to root_path
  end

  def update_attribute
    callroom = Callroom.find_by(user_id:current_user.id)
    if callroom.release == true 
      callroom.release = false
      callroom.save
      redirect_to callroom_path(callroom.id), alert: "非公開にしました"
    else callroom.release == false
      callroom.release = 1
      callroom.save
      redirect_to callroom_path(callroom.id), notice: "公開にしました"
    end
  end

  # def call
  #   respond_to do |format|
  #     format.html
  #     format.json do
  #       @student = current_user
  #       @callroom = Callroom.find(params[:id])
  #     end
  #   end
  # end

  def call
    respond_to do |format|
      format.html
      format.json do
        @callroom = Callroom.find(params[:id])
        if @callroom.release == true && @callroom.waitingroom.nil?
          @callroom.student_id = current_user.id
          @callroom.waitingroom = 0
          @callroom.save
          @student = current_user
        else @callroom.release == true && @callroom.waitingroom == 1 && @callroom.student_id == current_user.id
          @student = current_user
        # elsif @callroom.user_id == current_user.id
        # else
        end
      end
    end
  end
end

private
def callroom_params
  params.require(:callroom).permit(:title, :body, :image,:release).merge(user_id: current_user.id)
end